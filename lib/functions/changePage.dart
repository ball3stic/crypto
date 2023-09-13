import 'package:flutter/material.dart';

void changePage(Widget newPage, BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => newPage),
  );
}
