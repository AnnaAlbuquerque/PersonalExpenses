import 'package:flutter/material.dart';

import './expense_card.dart';
import '../../models/transaction.dart';

class ExpensesList extends StatelessWidget {
  final List<Transaction> list;
  final Function deleteTx;

  ExpensesList({@required this.list, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: list.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                ExcludeSemantics(
                  child: Container(
                      height: 200,
                      child: Image.asset('assets/img/waiting.png',
                          fit: BoxFit.cover)),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return ExpenseCard(
                  transaction: list[index],
                  delete: deleteTx,
                );
              },
              itemCount: list.length,
            ),
    );
  }
}
