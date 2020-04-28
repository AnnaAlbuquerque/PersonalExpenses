import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import './information_container.dart';
import './price_container.dart';

class ExpenseCard extends StatelessWidget {
  final Transaction transaction;

  ExpenseCard({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: <Widget>[
        //Widget for the price tag
        PriceContainer(value: transaction.amount),
        //Widget fot the information
        InformationContainer(
          title: transaction.title,
          date: transaction.date,
        )
      ]),
    );
  }
}
