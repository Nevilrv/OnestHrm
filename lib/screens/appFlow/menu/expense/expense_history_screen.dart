import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/manage_claim/manage_expense_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/expense_claim/manage_claims_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/expense/payment_history/payment_history_screen.dart';
import 'package:hrm_app/utils/res.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          tr("expense_history"),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold,color: AppColors.appBarColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ManageExpenseScreen())),
                leading: SvgPicture.asset('assets/expense/manage-expense.svg', height: 20,width: 20),
                title:  Text(tr("manage_expense")),
              ),
            ),
             Card(
              elevation: 2,
              child: ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ManageClaimsScreen())),
                leading: SvgPicture.asset('assets/expense/manage-claims.svg', height: 20,width: 20),
                title:  Text(tr("manage_claims")),
              ),
            ),
             Card(
              elevation: 2,
              child: ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PaymentHistoryScreen())),
                leading: SvgPicture.asset('assets/expense/payment-history-1.svg', height: 20,width: 20,),
                title:  Text(tr("payment_history")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
