import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationDate extends StatelessWidget {
  final DateTime date;

  InformationDate({this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat("dd/MM/yyyy").format(date),
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }
}
