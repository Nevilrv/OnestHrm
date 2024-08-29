import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_all_user.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/meeting_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MeetingCreateProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  File? attachmentPath;

  ///set all user data
  User? allUserData;

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<User> selectedItem = HashSet();

  ///time picker
  String? startTime;
  String? endTime;

  ///date picker
  String? monthYear;
  DateTime? selectedDate;

  Future postCreateMeeting(context) async {
    final formData = FormData.fromMap({
      "title": titleController.text,
      "description": descriptionController.text,
      "participants": userIds.join(','),
      "date": monthYear,
      "location": locationController.text,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
              filename: attachmentPath?.path)
          : null,
      "start_at": startTime,
      "end_at": endTime,
    });

    ///validation condition
    if (monthYear != null && startTime != null && endTime != null) {
      final response = await Repository.postCreateMeeting(formData);
      if (response['result'] == true) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
        reset();
        NavUtil.replaceScreen(context, const MeetingScreen());
      } else {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
      }
    } else {
      Fluttertoast.showToast(msg: tr("please_fill_the_required_fill"));
    }
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        monthYear = DateFormat('y-MM-dd').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  /// get data from all team mate screen
  /// AppreciateTeammate screen
  void getAllUserData(BuildContext context) async {
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
    selectedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MultiSelectEmployee()),
    );
    for (var element in selectedItem) {
      userIds.add(element.id!);
      userNames.add(element.name!);
    }
    notifyListeners();
  }

  Future<void> showTime(context, int start) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result != null) {
      ///if start value is 0 then, time will be set as start, or set as end time
      if (start == 0) {
        startTime = result.format(context);
      } else {
        endTime = result.format(context);
      }

      notifyListeners();
    }
  }

  ///Pick Attachment from Camera and Gallery
  Future<dynamic> pickAttachmentImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachmentPath = File(image!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachmentPath = File(imageGallery!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  reset() {
    titleController.clear();
    descriptionController.clear();
    allUserData = null;
    monthYear = null;
    locationController.clear();
    attachmentPath = null;
    startTime = null;
    endTime = null;
  }
}
