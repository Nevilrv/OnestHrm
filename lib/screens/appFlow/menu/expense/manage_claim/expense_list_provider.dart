import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/expense_model/expense_category_model.dart';
import 'package:hrm_app/data/model/expense_model/expense_list_details_model.dart';
import 'package:hrm_app/data/model/expense_model/expense_list_model.dart';
import 'package:hrm_app/data/server/respository/expense_repository.dart';
import 'package:hrm_app/utils/month_picker_dialog/month_picker_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../expense_details/expense_details.dart';

class ExpenseListProvider extends ChangeNotifier {
  TextEditingController addRemarksController = TextEditingController();
  ExpenseListModel? expenseListModel;
  ExpenseListDetailsModel? expenseListDetailsModel;
  List<DataM>? expenseList;
  DateTime? selectedDate;
  String? monthYear;
  bool isLoading = false;

  ///add expense variable
  ExpenseCategoryModel? expenseCategory;
  // ExpenseCategoryData? selectCategorydata;

  ///create expense variable
  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  File? attachmentPath;

  ///Expense details variable
  int? expenseId;

  ExpenseListProvider() {
    getDate();
    getExpenseList();
  }

  ///get all expense list:--------------------
  Future getExpenseList() async {
    var date = {'month': "$monthYear"};
    isLoading = true;
    final response = await ExpenseRepository.postExpenseList(date);
    expenseListModel = response!;
    expenseList = expenseListModel?.data?.expenseList?.dataM;
    isLoading = false;
    notifyListeners();
  }

  /// Send oll create remarks from here:------------
  Future sendRemarks() async {
    final data = {'remarks': addRemarksController.text};
    if (addRemarksController.text.isNotEmpty) {
      final response = await ExpenseRepository.sendClaimRemarks(data);
      if (response['result'] == true) {
        getExpenseList();
        Fluttertoast.showToast(msg: response['message']);
      }
    } else {
      Fluttertoast.showToast(msg: 'Remarks can not be empty');
    }
    addRemarksController.clear();
    notifyListeners();
  }

  ///get date:----------------------------
  ///for Expense list page
  getDate() {
    DateTime currentDate = DateTime.now();
    monthYear = DateFormat('MMMM,y').format(currentDate);
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        monthYear = DateFormat('MMMM,y').format(selectedDate!);
        getExpenseList();
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  ///expense details page :------------------------
  Future getDetails(id,context) async {
    ///collect expense id.
    ///api is not giving expense id in this api
    expenseId = id;

    EasyLoading.show(status: 'loading...');
    isLoading = true;
    final response = await ExpenseRepository.getExpenseListDetails(id);
    expenseListDetailsModel = response!;
    isLoading = false;
    EasyLoading.dismiss();

    ///here call all expense category list
    ///for find index of category
    await getExpenseCategory();

    // final categoryIndex = expenseCategory?.data?.indexWhere(
    //     (element) => element.name == expenseListDetailsModel?.data?.category);

    ///select category from category list
    // selectCategorydata = expenseCategory?.data?[categoryIndex!];

    ///image path will be null
    ///when enter details page
    attachmentPath = null;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
            const ExpenseDetails()));
    notifyListeners();
  }

  ///Delete expense from here:---------------
  deleteExpense(context) async {
    final response = await ExpenseRepository.deleteExpense(expenseId);
    Fluttertoast.showToast(msg: response['message']);
    if (response['result'] == true) {
      ///when delete expense need to re-call expense list
      getExpenseList();
      Navigator.pop(context);
    }
  }

  ///Add expense category :--------------------
  Future getExpenseCategory() async {
    // selectCategorydata?.id = null;
    isLoading = true;
    final response = await ExpenseRepository.getExpenseCategory();
    expenseCategory = response;
    isLoading = false;
    notifyListeners();
  }

  // ///Selected category type;
  // selectCategory(ExpenseCategoryData val) {
  //   selectCategorydata = val;
  //   notifyListeners();
  // }

  /// expense add:-----------------
  Future expenseAdd(context) async {
    var fromData = FormData.fromMap({
      // "expense_category_id": selectCategorydata?.id,
      "remarks": remarksController.text,
      "amount": amountController.text,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
              filename: attachmentPath?.path)
          : null,
    });
    final response = await ExpenseRepository.postExpenseAdd(fromData);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: response['message']);
      await getExpenseList();
      attachmentPath = null;
      Navigator.pop(context);
      Navigator.pop(context);
    }
    remarksController.clear();
    amountController.clear();
  }

  /// expense Edit from here:-----------------
  Future expenseEdit({context, remarks, amount}) async {
    var fromData = FormData.fromMap({
      // "expense_category_id": selectCategorydata?.id,
      "remarks": remarks,
      "amount": amount,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
              filename: attachmentPath?.path)
          : expenseListDetailsModel?.data?.attachmentFile,
    });

    final response =
        await ExpenseRepository.postExpenseEdit(fromData, expenseId);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: response['message']);
      await getExpenseList();
      // Navigator.removeRoute(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) => const ExpenseLogCategory()));
      attachmentPath = null;
      Navigator.pop(context);
      Navigator.pop(context);
    }
    remarksController.clear();
    amountController.clear();
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
}
