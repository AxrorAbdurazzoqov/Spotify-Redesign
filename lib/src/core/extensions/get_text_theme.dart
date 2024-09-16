import 'package:flutter/material.dart';

extension GetTextTheme on BuildContext {
  
  TextStyle? get textSmall => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get textMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get textLarge => Theme.of(this).textTheme.headlineLarge;
}