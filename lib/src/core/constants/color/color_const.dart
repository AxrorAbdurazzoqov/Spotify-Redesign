import 'package:flutter/material.dart';

class ColorConst {
  static final _instance = ColorConst.init();
  static ColorConst get instance => _instance;
  ColorConst.init();

  final Color backgroundDark = const Color(0xff1C1B1B);
  final Color black = const Color(0xff0D0C0C);
  final Color green = const Color(0xff38B432);
  final Color lightGreen = const Color(0xff42C83C);
  final Color blue = const Color(0xff288CE9);
  final Color grey = const Color(0xff797979);
  final Color white = const Color(0xffFFFFFF);
  final Color red = const Color(0xffFF0000);

  //! navbar colors
  final Color navbarDark = const Color(0xff343434);
  final Color navbarLight = const Color(0xffE1E1E1);
}
