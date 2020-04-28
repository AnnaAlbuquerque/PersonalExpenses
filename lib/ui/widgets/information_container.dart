import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationContainer extends StatelessWidget {
  final String title;
  final DateTime date;

  InformationContainer({this.title, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
      Text(
        DateFormat("dd/MM/yyyy").format(date),
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        ),
    ]);
  }
}
