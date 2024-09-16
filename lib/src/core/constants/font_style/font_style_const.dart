import 'package:flutter/material.dart';

class FontStyleConst {
  static final FontStyleConst _instance = FontStyleConst.init();
  static FontStyleConst get instance => _instance;
  FontStyleConst.init();

  final TextStyle small = const TextStyle(fontSize: 14, fontFamily: 'Raleway');
  final TextStyle medium = const TextStyle(fontSize: 17, fontFamily: 'Raleway');
  final TextStyle large = const TextStyle(fontSize: 30, fontFamily: 'Raleway');
}