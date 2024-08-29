import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/data/model/expense_model/payment_history_model.dart';
import 'package:hrm_app/data/server/respository/expense_repository.dart';
import 'package:hrm_app/utils/month_picker_dialog/month_picker_dialog.dart';
import 'package:hrm_app/utils/res.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  DateTime? selectedDate;
  String? monthYear;
  PaymentHistoryModel? paymentHistory;
  bool isLoading = false;

  @override
  void initState() {
    getDate();
    getPaymentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("payment_history"),
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.appBarColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        selectDate(context);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.angleLeft,
                        size: 30,
                        color: AppColors.colorPrimary,
                      )),
                  const Spacer(),
                  Center(
                      child: Text(
                    "$monthYear",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 30,
                      color: AppColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? paymentHistory!.data!.data!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: paymentHistory?.data?.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final data = paymentHistory?.data?.data?[index];
                            return Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      '${data?.paymentDate}')),
                                              Text('${data?.paidAmount}')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${data?.invoiceNumber}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            42),
                                                    color: const Color(
                                                        0xFFFEDADD)),
                                                child: Text(
                                                  '${data?.status}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    :  Expanded(
                        child: Center(
                            child: Text(
                          tr("no_payment_history_found"),
                          style: const TextStyle(
                              color: Color(0x65555555),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        )),
                      )
                : const SizedBox()

            ///card ui from here :----------------
          ],
        ),
      ),
    );
  }

  getDate() {
    DateTime currentDate = DateTime.now();
    monthYear = DateFormat('MMMM,y').format(currentDate);
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
        setState(() {
          selectedDate = date;
          monthYear = DateFormat('MMMM,y').format(selectedDate!);
          getPaymentList();
        });
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
      }
    });
  }

  ///Payment history api call from here
  Future getPaymentList() async {

    final data = {'month': '$monthYear'};

    final response = await ExpenseRepository.postPaymentList(data);
    paymentHistory = response;
    isLoading = true;
    setState(() {});
  }
}
