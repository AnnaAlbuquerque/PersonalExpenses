import 'package:flutter/material.dart';

class PriceContainer extends StatelessWidget {
  final double value;

  PriceContainer({this.value});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Text('\$ $value')
          ),
        ),
    );
  }
}
