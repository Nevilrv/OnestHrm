import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/api_provider/api_provider.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/live_traking/location_provider.dart';
import 'package:hrm_app/screens/appFlow/home/attendeance/attendance.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_time_screen.dart';
import 'package:hrm_app/screens/appFlow/home/components/appointment_card.dart';
import 'package:hrm_app/screens/appFlow/home/components/appreciate_card.dart';
import 'package:hrm_app/screens/appFlow/home/components/event_cart_widgets.dart';
import 'package:hrm_app/screens/appFlow/home/home_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/notification_service.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'components/holiday_card_widget.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<ApiProvider>();
    // final locationProvider = context.watch()<LocationProvider>();

    notificationPlugin.scheduleNotification(
        0,
        tr("attendance_alert"),
        tr("good_morning_have_you_checked_in_office_yet"),
        settingProvider.inHour ?? 10,
        settingProvider.inMin ?? 0,
        settingProvider.inSec ?? 0);

    notificationPlugin.scheduleNotification(
        1,
        tr("check_out_alert"),
        tr("good_evening_have_you_checked_out_office_yet"),
        settingProvider.outHour ?? 18,
        settingProvider.outMin ?? 0,
        settingProvider.outSec ?? 0);

    return ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child:
          Consumer<LocationProvider>(builder: (context, locationProvider, _) {
        return NoInternetScreen(
          child: ChangeNotifierProvider(
            create: (context) => HomeProvider(context, locationProvider),
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Stack(
                      children: [
                        ///blue background
                        Positioned(
                          right: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/images/home_background_one.png',
                            fit: BoxFit.cover,
                            color: AppColors.colorPrimary,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: provider.isArabic ? 12 : 0,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            provider.timeWish != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: Text(
                                                      provider.timeWish?.wish ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.5,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Column(
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor:
                                                              const Color(
                                                                  0xFFE8E8E8),
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                              height: 14,
                                                              width: 120,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFE8E8E8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // radius of 10// green as background color
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: provider.timeWish != null
                                                  ? Text(
                                                      '${provider.userName}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.5,
                                                          color: Colors.white),
                                                    )
                                                  : Shimmer.fromColors(
                                                      baseColor: const Color(
                                                          0xFFE8E8E8),
                                                      highlightColor:
                                                          Colors.white,
                                                      child: Container(
                                                          height: 14,
                                                          width: 160,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFFE8E8E8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10), // radius of 10// green as background color
                                                          )),
                                                    ),
                                            ),
                                            provider.timeWish != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Text(
                                                      provider.timeWish
                                                              ?.subTitle ??
                                                          '',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.5,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          baseColor:
                                                              const Color(
                                                                  0xFFE8E8E8),
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                              height: 12,
                                                              width: 260,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFE8E8E8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // radius of 10// green as background color
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Shimmer.fromColors(
                                                          baseColor:
                                                              const Color(
                                                                  0xFFE8E8E8),
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                              height: 12,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFE8E8E8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // radius of 10// green as background color
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SvgPicture.network(
                                        provider.timeWish?.image ?? "",
                                        semanticsLabel: 'A shark?!',
                                        height: 60,
                                        width: 60,
                                        placeholderBuilder:
                                            (BuildContext context) =>
                                                const SizedBox(),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  provider.todayData != null
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: const Text(
                                            'today_summary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5,
                                                color: Colors.white,
                                                letterSpacing: 0.5),
                                          ).tr(),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Shimmer.fromColors(
                                            baseColor: const Color(0xFFE8E8E8),
                                            highlightColor: Colors.white,
                                            child: Container(
                                                height: 14,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE8E8E8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // radius of 10// green as background color
                                                )),
                                          ),
                                        ),
                                  const SizedBox(height: 8),

                                  ///Upcoming Events
                                  provider.todayData != null
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Row(
                                              children: List.generate(
                                            provider.todayData?.length ?? 0,
                                            (index) => EventCard(
                                              data: provider.todayData![index],
                                              onPressed: () =>
                                                  provider.getRoutSlag(
                                                      context,
                                                      provider.todayData![index]
                                                          .slug),
                                            ),
                                          )),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: List.generate(
                                                6,
                                                (index) => SizedBox(
                                                  width: 160.0,
                                                  height: 180.0,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        const Color(0xFFE8E8E8),
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 2),
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        color: const Color(
                                                            0xFFE8E8E8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            ///Check In Check Out here:----------------------------
                            provider.isCheckIn != null
                                ? Visibility(
                                    visible: provider.isCheckIn ?? false,
                                    child: Card(
                                      elevation: 2,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: InkWell(
                                          onTap: () {
                                            NavUtil.navigateScreen(
                                                context,
                                                const Attendance(
                                                  navigationMenu: false,
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SvgPicture.asset(
                                                    provider.checkStatus ==
                                                            "Check In"
                                                        ? 'assets/home_icon/in.svg'
                                                        : 'assets/home_icon/out.svg',
                                                    height: 40,
                                                    width: 40,
                                                    placeholderBuilder: (BuildContext
                                                            context) =>
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(30.0),
                                                            child:
                                                                const CircularProgressIndicator()),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                              provider.checkStatus ==
                                                                      "Check In"
                                                                  ? "start_time"
                                                                  : "done_for_today",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 1.5,
                                                                  letterSpacing:
                                                                      0.5))
                                                          .tr(),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        tr(provider
                                                                .checkStatus ??
                                                            'Check In'),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .colorPrimary,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.5,
                                                            letterSpacing: 0.5),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: const Color(0xFFE8E8E8),
                                          highlightColor: Colors.white,
                                          child: Container(
                                              height: 100,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8E8E8),
                                                borderRadius: BorderRadius.circular(
                                                    10), // radius of 10// green as background color
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),

                            ///Break In Out from here:-----------------------------
                            Visibility(
                              visible: provider.isBreak ?? false,
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: InkWell(
                                  onTap: () {
                                    NavUtil.navigateScreen(
                                        context,
                                        const BreakTime(
                                          diffTimeHome: '',
                                          hourHome: 0,
                                          minutesHome: 0,
                                          secondsHome: 0,
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Lottie.asset(
                                              'assets/images/tea_time.json',
                                              height: 65,
                                              width: 65),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('break_time',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.5,
                                                          letterSpacing: 0.5))
                                                  .tr(),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'start_break',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.colorPrimary,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5,
                                                    letterSpacing: 0.5),
                                              ).tr(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            ///upcoming events:----------------------
                            provider.upcomingItems != null
                                ? Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    margin: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SvgPicture.asset(
                                        //   'assets/home_icon/upcoming_events_banner.svg',
                                        //   height: 185,
                                        //   width: double.infinity,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        Image.asset(
                                          'assets/images/new_Upcoming_Event.png',
                                          height: 185,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('upcoming_events',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.5,
                                                          letterSpacing: 0.5))
                                                  .tr(),
                                              const Text(
                                                      'public_holiday_and_even',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.5,
                                                          color:
                                                              Color(0xFF555555),
                                                          letterSpacing: 0.5))
                                                  .tr(),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Column(
                                                children:
                                                    provider.upcomingItems!
                                                        .map(
                                                          (e) => HolidayWidgets(
                                                              upcomingItems: e),
                                                        )
                                                        .toList(),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 16, right: 16),
                                        child: Shimmer.fromColors(
                                          baseColor: const Color(0xFFE8E8E8),
                                          highlightColor: Colors.white,
                                          child: Container(
                                              height: 180,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8E8E8),
                                                borderRadius: BorderRadius.circular(
                                                    10), // radius of 10// green as background color
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor:
                                                  const Color(0xFFE8E8E8),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                  height: 14,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFE8E8E8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // radius of 10// green as background color
                                                  )),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor:
                                                  const Color(0xFFE8E8E8),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                  height: 14,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFE8E8E8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // radius of 10// green as background color
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Shimmer.fromColors(
                                          baseColor: const Color(0xFFE8E8E8),
                                          highlightColor: Colors.white,
                                          child: Container(
                                              height: 80,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8E8E8),
                                                borderRadius: BorderRadius.circular(
                                                    10), // radius of 10// green as background color
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),

                            ///=========== Appointments ============
                            provider.appointmentsItems != null &&
                                    provider.appointmentsItems!.isNotEmpty
                                ? AppointmentCard(
                                    provider: provider,
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),

                            ///  ================ Appreciated Card UI =========
                            const AppreciateCard(),

                            /// ============== Current Month ========
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: const Text(
                                'current_month',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    letterSpacing: 0.5),
                              ).tr(),
                            ),
                            const SizedBox(height: 8),
                            provider.currentMothList != null
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      children: List.generate(
                                        provider.currentMothList?.length ?? 0,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14.0),
                                              child: SizedBox(
                                                width: 125,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      '${provider.currentMothList?[index].image}',
                                                      height: 25,
                                                      color: AppColors
                                                          .colorPrimary,
                                                    ),
                                                    Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          '${provider.currentMothList?[index].number ?? 0}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 1.5,
                                                                  letterSpacing:
                                                                      0.5),
                                                        ),
                                                        const Text(
                                                          'days',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF777777),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 4,
                                                              letterSpacing:
                                                                  0.5),
                                                        ).tr(),
                                                      ],
                                                    ),
                                                    Text(
                                                      tr(provider
                                                              .currentMothList?[
                                                                  index]
                                                              .title ??
                                                          ""),
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.5,
                                                          letterSpacing: 0.5),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(height: 100),
                            const SizedBox(height: 80)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
