import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/expense_model/expense_category_model.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/expense_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/add_expense.dart';
import 'package:provider/provider.dart';

class ExpenseLogCategory extends StatefulWidget {
  const ExpenseLogCategory({Key? key, this.fromEditPage}) : super(key: key);

  final int? fromEditPage;

  @override
  State<ExpenseLogCategory> createState() => _ExpenseLogCategoryState();
}

class _ExpenseLogCategoryState extends State<ExpenseLogCategory> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseListProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("expense_log"),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              tr("select_type_of_expense"),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            // provider.isLoading == false
            //     ? Expanded(
            //         child: ListView.builder(
            //           itemCount: provider.expenseCategory?.data?.categories?.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             final data = provider.expenseCategory?.data?.categories?[index];
            //             return Card(
            //               child: RadioListTile<ExpenseCategoryData?>(
            //                 title: Text(data?.name ?? ''),
            //                 value: data,
            //                 groupValue: provider.selectCategorydata,
            //                 onChanged: (ExpenseCategoryData? value) {
            //                   provider.selectCategory(value!);
            //                 },
            //               ),
            //             );
            //           },
            //         ),
            //       )
            //     : const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // if (provider.selectCategorydata?.id != null) {
                  //   widget.fromEditPage == 1
                  //       ? Navigator.pop(context)
                  //       : Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (_) => const ExpenseLogExpense()));
                  // } else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return  CustomDialogError(
                  //           title: tr("select_category"),
                  //           subTitle:
                  //               tr("you_must_be_select_a_category"),
                  //         );
                  //       });
                  // }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child:  Text(tr("next"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
