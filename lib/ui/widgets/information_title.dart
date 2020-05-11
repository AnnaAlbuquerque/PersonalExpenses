import 'package:flutter/material.dart';

class InformationTitle extends StatelessWidget {
  final String title;

  InformationTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
