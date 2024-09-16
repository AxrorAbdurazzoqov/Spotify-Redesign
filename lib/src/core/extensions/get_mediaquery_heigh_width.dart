import 'package:flutter/material.dart';

extension GetMediaqueryHeighWidth on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;
  double get getWidth => MediaQuery.of(this).size.width;
}
