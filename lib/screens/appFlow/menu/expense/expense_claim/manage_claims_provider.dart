import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/server/respository/expense_repository.dart';
import 'package:hrm_app/utils/month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import '../../../../../data/model/expense_model/expanse_claim_model.dart';

class ManageClaimsProvider extends ChangeNotifier {
  ExpenseClaimModel? expenseClaimModel;
  DateTime? selectedDate;
  String? monthYear;
  bool isLoading = false;

  ManageClaimsProvider() {
    getDate();
    getExpanseClaimList();
  }

  getExpanseClaimList() async {
    final data = {"month": monthYear};
    final response = await ExpenseRepository.postExpanseClaim(data);
    expenseClaimModel = response;
    isLoading = true;
    notifyListeners();
  }

  ///get date:----------------------------
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
        getExpanseClaimList();
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}
