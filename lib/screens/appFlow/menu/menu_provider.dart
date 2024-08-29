import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/menu/menu_model.dart';
import 'package:hrm_app/data/server/respository/menu_repository.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_time_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave/daily_leave_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_summary/leave_summary.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/meeting_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/phonebook_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/reports_screen/report_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

import '../home/attendeance/attendance.dart';
import 'approval/approval.dart';
import 'expense_new/expense_list/expense_list.dart';
import 'support/support_ticket/support_screen.dart';

class MenuProvider extends ChangeNotifier {
  String? userName;
  String? userPhone;
  MenuModel? menuModel;
  List<Datum>? menuList;
  String? profileImage;

  MenuProvider() {
    getUserData();
    getMenuList();
  }

  void getUserData() async {
    userName = await SPUtill.getValue(SPUtill.keyName);
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }

  getMenuList() async {
    final response = await MenuRepository.getAllMenu();
    if (response.httpCode == 200) {
      menuList = response.data!.data!.data;
    }
    notifyListeners();
  }

  getRoutSlag(context, String? name) {
    switch (name) {
      case 'support':
        return NavUtil.navigateScreen(context, const SupportScreen());
      case 'attendance':
        return NavUtil.navigateScreen(context, const Attendance(navigationMenu: true,));
      case 'notice':
        return NavUtil.navigateScreen(context, const NoticeScreen());
      case 'expense':
        return NavUtil.navigateScreen(context,  const ExpenseList());
      case 'leave':
        return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'approval':
        return NavUtil.navigateScreen(context, const ApprovalScreen());
        // return NavUtil.navigateScreen(context, const ExpanseCategory());
      case 'phonebook':
        return NavUtil.navigateScreen(context, const PhonebookScreen());
      case 'visit':
        return NavUtil.navigateScreen(context, const VisitScreen());
      case 'meeting':
        return NavUtil.navigateScreen(context, const MeetingScreen());
      case 'appointments':
        return NavUtil.navigateScreen(context, const AppointmentScreen());
      case 'break':
        return NavUtil.navigateScreen(
            context,
            NavUtil.navigateScreen(
                context,
                const BreakTime(
                  diffTimeHome: '',
                  hourHome: 0,
                  minutesHome: 0,
                  secondsHome: 0,
                )));
      case 'feedback':
        return Fluttertoast.showToast(msg: 'feedback');
      case 'report':
        return NavUtil.navigateScreen(context, const ReportScreen());
      case 'daily-leave':
        return NavUtil.navigateScreen(context, const DailyLeave());
      default:
        return debugPrint('default');
    }
  }
}
