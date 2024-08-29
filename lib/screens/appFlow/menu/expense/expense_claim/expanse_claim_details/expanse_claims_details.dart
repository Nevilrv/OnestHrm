import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/server/respository/expense_repository.dart';
import 'package:hrm_app/utils/res.dart';


import '../../../../../../data/model/expense_model/expanse_claims_details.dart';

class ExpenseClaimDetailsScreen extends StatefulWidget {
  const ExpenseClaimDetailsScreen({Key? key, required this.id})
      : super(key: key);

  final int id;

  @override
  State<ExpenseClaimDetailsScreen> createState() =>
      _ExpenseClaimDetailsScreenState();
}

class _ExpenseClaimDetailsScreenState extends State<ExpenseClaimDetailsScreen> {
  ExpenseClaimDetailsModel? claimDetails;
  bool? isLoading = true;

  @override
  void initState() {
    getClaimDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr("expanse_claims_details"),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.appBarColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('${claimDetails?.data?.month ?? ''} ${tr("Expense Details")}'),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          color: const Color(0xFFF3F6FD),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              Text(tr("date")),
                              Text(tr("amount")),
                            ],
                          ),
                        ),
                        claimDetails?.data != null
                            ? Column(
                                children: claimDetails!.data!.claimData!.data!
                                    .map((data) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade300))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.category!,
                                                    style: const TextStyle(
                                                        height: 1.5,
                                                        color:
                                                            Color(0xFF555555)),
                                                  ),
                                                  Text(
                                                    data.date!,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      height: 1.5,
                                                      color: Color(0xFF999999),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                data.amount!,
                                                style: const TextStyle(
                                                    color: Color(0xFF555555)),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList())
                            : Container(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFFE7EBF9),
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade300))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    tr("total_amount"),
                                    style: const TextStyle(
                                        height: 1.5, color: Color(0xFF555555)),
                                  ),
                                  const Text(
                                    '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: Color(0xFF999999),
                                    ),
                                  ),
                                ],
                              ),
                               Text(
                                claimDetails?.data?.totalAmount ?? '',
                                style: const TextStyle(color: Color(0xFF555555)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future getClaimDetails() async {
    isLoading == true;
    final response = await ExpenseRepository.postExpenseClaimDetails(widget.id);
    claimDetails = response;
    isLoading == false;
    setState(() {});
  }
}
