import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/expense_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/expense_log_category.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ManageExpenseScreen extends StatelessWidget {
  const ManageExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseListProvider>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            remarksFloatingActionButton(context, provider),
            addFloatingActionButton(context, provider),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          tr("expense_list"),
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.appBarColor),
        ),
      ),
      body: Column(
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
          Container(
            color: const Color(0xff6AB026),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xff3F811D),
                ),
                const SizedBox(
                  width: 10,
                ),
                 Text(
                  tr("expense"),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  provider.expenseListModel?.data?.totalAmount ?? '0',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          provider.isLoading == false

              ///if expendList is empty then show no data found
              ? provider.expenseList!.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: provider.expenseList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider.expenseList?[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              child: ListTile(
                                onTap: () async {
                                  await provider.getDetails(data?.id, context);
                                },
                                title: Text(
                                  "${data?.category ?? ''} : ${data?.amount ?? ''}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                subtitle: Text(
                                  data?.remarks ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.angleRight,
                                    size: 25,
                                    color: AppColors.colorPrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  :  Expanded(
                      child: Center(
                          child: Text(
                        tr("no_expense_found"),
                        style: const TextStyle(
                            color: Color(0x65555555),
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      )),
                    )
              : const SizedBox()
        ],
      ),
    );
  }

  ///add expense floating action button
  FloatingActionButton addFloatingActionButton(
      BuildContext context, ExpenseListProvider provider) {
    return FloatingActionButton(
      heroTag: 'add',
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ExpenseLogCategory()));
        await provider.getExpenseCategory();
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  ///remarks expense floating action button
  FloatingActionButton remarksFloatingActionButton(
      BuildContext context, ExpenseListProvider provider) {
    return FloatingActionButton(
      heroTag: 'remarks',
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Center(
                child: Text(
              tr("remarks"),
              style: const TextStyle(fontSize: 16),
            )),
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorPrimary),
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                maxLines: 4,
                controller: provider.addRemarksController,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text(tr("cancel")),
                onPressed: () {
                  provider.addRemarksController.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child:  Text(tr("send")),
                onPressed: () {
                  provider.sendRemarks();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
      child: const Icon(
        Icons.mail_outline,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
