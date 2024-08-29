import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/edit_expense.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/expense_list_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ExpenseDetails extends StatelessWidget {
   const ExpenseDetails({Key? key, this.id}) : super(key: key);

  final int? id;

  @override
  Widget build(BuildContext context) {
    // final settingProvider = context.watch<ApiProvider>();
    ///currency symbol
    final provider = context.watch<ExpenseListProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("expense_detail"),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.appBarColor),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                 Text(
                 tr("month"),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  provider.expenseListDetailsModel?.data?.month ?? '',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(
                 tr("type"),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 57,
                ),
                Text(
                  provider.expenseListDetailsModel?.data?.category ?? '',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.account_balance_wallet,
                  size: 18,
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                 Text(
                  tr("amount"),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 38,
                ),
                Text(
                  '${provider.expenseListDetailsModel?.data?.amount ?? ''}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                 Text(
                  tr("remarks"),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    provider.expenseListDetailsModel?.data?.remarks ?? '',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                 Text(
                  tr("Created at"),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  provider.expenseListDetailsModel?.data?.date ?? '',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              tr("attachment"),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.network(
                  provider.expenseListDetailsModel?.data?.attachmentFile ?? '',
                  height: 80,
                  width: 80,
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.deleteExpense(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child:  Text(tr("delete"),
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),

              ///Edit expense button:-------------------
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditExpense()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text('Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
