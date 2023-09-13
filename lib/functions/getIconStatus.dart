import 'package:flutter/material.dart';

Icon getStatusIcon(double changePercent) {
  Icon? icon;
  changePercent >= 0
      ? icon = Icon(
          Icons.trending_up,
          color: Colors.green[800],
        )
      : icon = Icon(
          Icons.trending_down,
          color: Colors.red[800],
        );
  return icon;
}
