import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/expense_list_provider.dart';
import 'package:provider/provider.dart';

import 'manage_claim/expense_log_category.dart';

class EditExpense extends StatelessWidget {
  const EditExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseListProvider>();
    TextEditingController amountController = TextEditingController(
        text: '${provider.expenseListDetailsModel?.data?.amount}');
    TextEditingController remarksController = TextEditingController(
        text: '${provider.expenseListDetailsModel?.data?.remarks}');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr("expense_update"),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  tr("category"),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.blue[50],
                  child: ListTile(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ExpenseLogCategory(
                                    fromEditPage: 1,
                                  )));
                      await provider.getExpenseCategory();
                    },
                    leading: const Icon(Icons.list_alt),
                    trailing:  Text(
                      tr("change"),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    // title: provider.selectCategorydata?.name != null
                    //     ? Text(provider.selectCategorydata!.name!)
                    //     : Text(
                    //         provider.expenseListDetailsModel!.data!.category!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        tr("amount"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          labelText: tr("enter_amount"),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                       Text(
                        tr("remarks"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: remarksController,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          hintText: tr("enter_remarks"),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                       Text(
                        tr("attachment"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.0,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: DottedBorder(
                          color: const Color(0xffC7C7C7),
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(3),
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 10, vertical: 16),
                          strokeWidth: 2,
                          child: TextButton(
                            onPressed: () =>
                                provider.pickAttachmentImage(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Icon(
                                  Icons.upload_file,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                 Text(
                                  tr("upload_your_file"),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: provider.attachmentPath != null
                                ? Image.file(
                                    provider.attachmentPath!,
                                    height: 80,
                                    width: 80,
                                  )
                                : Image.network(
                                    provider.expenseListDetailsModel?.data
                                            ?.attachmentFile ??
                                        '',
                                    height: 80,
                                    width: 80,
                                  )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            provider.expenseEdit(
                                context: context,
                                remarks: remarksController.text,
                                amount: amountController.text);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => const ExpenseScreen()));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child:  Text(tr("update_Expanse"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
