import 'package:expense_planner/ui/widgets/information_date.dart';
import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import './information_title.dart';
import './price_container.dart';

class ExpenseCard extends StatelessWidget {
  final Transaction transaction;
  final Function delete;

  ExpenseCard({this.transaction, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: PriceContainer(value: transaction.amount),
        title: InformationTitle(
          title: transaction.title,
        ),
        subtitle: InformationDate(
          date: transaction.date,
        ),
        trailing: Semantics(
          label: "Delete Button",
          hint: "Press to delete ${transaction.title}",
          child: IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => delete(transaction.id),
          ),
        ),
      ),
    );
  }
}
