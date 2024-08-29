import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/expense_claim/manage_claims_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'expanse_claim_details/expanse_claims_details.dart';

class ManageClaimsScreen extends StatelessWidget {
  const ManageClaimsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManageClaimsProvider(),
      child: Consumer<ManageClaimsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr("expanse_claims"),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.appBarColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      provider.selectDate(context);
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.selectDate(context);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.angleLeft,
                              size: 30,
                              color: AppColors.colorPrimary,
                            )),
                        const Spacer(),
                        Center(
                            child: Text(
                          "${provider.monthYear}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            provider.selectDate(context);
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
                  provider.isLoading == true
                      ? provider.expenseClaimModel!.data!.data!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: provider
                                    .expenseClaimModel?.data?.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider
                                      .expenseClaimModel?.data?.data?[index];
                                  return Card(
                                    elevation: 2,
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ExpenseClaimDetailsScreen(
                                                  id: data!.id!,
                                                )),
                                      ),
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
                                                        SizedBox(
                                                            width: 135,
                                                            child: Text(
                                                                data?.claimDate! ??
                                                                    '')),
                                                        Expanded(
                                                            child: Text(
                                                                '${data!.dueAmount}'))
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: 135,
                                                            child: Text(
                                                              data.invoiceNumber!,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            )),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          42),
                                                              color: const Color(
                                                                  0xFFFEDADD)),
                                                          child: Text(
                                                            data.statusId!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: const Color(
                                                        0xFFF5F5F5)),
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              ),
                            )
                          :  Expanded(
                              child: Center(
                                  child: Text(
                              tr("no_Expanse_claims_found"),
                              style: const TextStyle(
                                  color: Color(0x65555555),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            )))
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
