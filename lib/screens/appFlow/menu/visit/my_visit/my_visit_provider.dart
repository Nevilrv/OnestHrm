import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_visit_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class MyVisitProvider extends ChangeNotifier{
  ResponseVisitList? visitList;
  bool isLoading = false;

  MyVisitProvider(){
    getVisitList();
  }
  getVisitList() async {
    var apiResponse = await Repository.getVisitListApi();
    if (apiResponse.result == true) {
      visitList = apiResponse.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}