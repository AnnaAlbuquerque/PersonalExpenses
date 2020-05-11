import 'package:flutter/material.dart';

import './expense_card.dart';
import '../../models/transaction.dart';

class ExpensesList extends StatelessWidget {
  final List<Transaction> list;
  final Function deleteTx;

  ExpensesList({@required this.list, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
      ? LayoutBuilder(
        builder: (ctx, constraints){
          return Column(
            children: <Widget>[
              Text(
                "No transactions added yet!",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 20,
              ),
              ExcludeSemantics(
                child: Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/img/waiting.png',
                        fit: BoxFit.cover)),
              ),
            ],
          );
        },
      )
    : ListView.builder(
        itemBuilder: (ctx, index) {
          return ExpenseCard(
            transaction: list[index],
            delete: deleteTx,
          );
        },
        itemCount: list.length,
      );
  }
}
