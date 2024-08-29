import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/language/language_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/privacy_policy/privacy_policy_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/support_policy/support_policy_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/drawer/terms_conditions/terms_conditions_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/auth/splash_screen/splash_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key, this.provider}) : super(key: key);

  final MenuProvider? provider;

  @override
  Widget build(BuildContext context) {
    // List<MenuDrawerModel> accountList = [
    //   MenuDrawerModel(
    //       title: 'Leave',
    //       iconData: 'assets/menu_drawer_icons/leave.svg',
    //       onTap: () => NavUtil.navigateScreen(context, const LeaveSummary())),
    //   MenuDrawerModel(
    //       title: 'Teams',
    //       iconData: 'assets/menu_drawer_icons/team.svg',
    //       onTap: () => Fluttertoast.showToast(msg: 'Under Development')),
    //   MenuDrawerModel(
    //       title: 'Tasks',
    //       iconData: 'assets/menu_drawer_icons/tasks.svg',
    //       onTap: () => NavUtil.navigateScreen(context, const TaskListScreen())),
    // ];

    List<MenuDrawerModel> settingList = [
      // MenuDrawerModel(
      //     title: 'Dark Mode',
      //     iconData: 'assets/menu_drawer_icons/dark-mode.svg',
      //     onTap: () => Fluttertoast.showToast(msg: 'Under Development')),
      // MenuDrawerModel(
      //     title: 'Time Zone',
      //     iconData: 'assets/menu_drawer_icons/time-zone.svg',
      //     onTap: () => NavUtil.navigateScreen(context, const TimeZone())),
      // MenuDrawerModel(
      //     title: 'IP Settings',
      //     iconData: 'assets/menu_drawer_icons/ip-settings.svg',
      //     onTap: () =>
      //         NavUtil.navigateScreen(context, const IpSettingScreen())),
      // MenuDrawerModel(
      //     title: 'Working Mode',
      //     iconData: 'assets/menu_drawer_icons/working-mode.svg',
      //     onTap: () => Fluttertoast.showToast(msg: 'Under Development')),
      MenuDrawerModel(
          title: tr("language_change"),
          iconData: 'assets/menu_drawer_icons/language-change.svg',
          onTap: () => NavUtil.navigateScreen(context, const LanguageScreen())),
    ];

    List<MenuDrawerModel> supportList = [
      // MenuDrawerModel(
      //     title: 'Emergency Call',
      //     iconData: 'assets/menu_drawer_icons/emergency-call.svg',
      //     onTap: () => Fluttertoast.showToast(msg: 'Under Development')),
      MenuDrawerModel(
          title: tr("support_policy"),
          iconData: 'assets/menu_drawer_icons/support-policy.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const SupportPolicyScreen())),
      MenuDrawerModel(
          title: tr("privacy_policy"),
          iconData: 'assets/menu_drawer_icons/privacy-policy.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const PrivacyPolicyScreen())),
      MenuDrawerModel(
          title: tr("terms_conditions"),
          iconData: 'assets/menu_drawer_icons/terms-condition.svg',
          onTap: () =>
              NavUtil.navigateScreen(context, const TermsConditionsScreen())),
      MenuDrawerModel(
        title: tr("Logout"),
        iconData: 'assets/menu_drawer_icons/logout.svg',
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content:  Text(tr("are_you_sure_you_want_to_logout")),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:  Text(tr("no"))),
              TextButton(
                  onPressed: () async {
                    logOutFunctionality(context);
                  },
                  child:  Text(tr("yes"))),
            ],
          ),
        ),
      ),
    ];
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          color: AppColors.colorPrimary,
          child: Column(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: "${provider?.profileImage}",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/placeholder_image.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                provider?.userName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      tr("setting"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                    Column(
                      children: settingList
                          .map((e) => buildDrawerListTile(
                              title: e.title,
                              iconData: e.iconData,
                              onTap: e.onTap))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                     tr("support"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                    Column(
                      children: supportList
                          .map((e) => buildDrawerListTile(
                              title: e.title,
                              iconData: e.iconData,
                              onTap: e.onTap))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildDrawerListTile(
      {String? title, Function()? onTap, String? iconData}) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(iconData ?? ''),
      title: Text(title ?? ''),
    );
  }
}

class MenuDrawerModel {
  String? title;
  String? iconData;
  Function()? onTap;

  MenuDrawerModel({this.title, this.iconData, this.onTap});
}

logOutFunctionality(context) async {
  await SPUtill.deleteKey(SPUtill.keyAuthToken);
  await SPUtill.deleteKey(SPUtill.keyUserId);
  await SPUtill.deleteKey(SPUtill.keyProfileImage);
  await SPUtill.deleteKey(SPUtill.keyCheckInID);
  await SPUtill.deleteKey(SPUtill.keyName);
  await SPUtill.deleteKey(SPUtill.keyIsAdmin);
  await SPUtill.deleteKey(SPUtill.keyIsHr);
  NavUtil.pushAndRemoveUntil(context, const SplashScreen());
}
