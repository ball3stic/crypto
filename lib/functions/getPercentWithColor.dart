import 'package:flutter/material.dart';

Widget getPercentWithColor(double changePercent) {
  return Text(
    changePercent.toStringAsFixed(2),
    style: TextStyle(
      color: changePercent >= 0 ? Colors.green : Colors.red,
    ),
  );
}
