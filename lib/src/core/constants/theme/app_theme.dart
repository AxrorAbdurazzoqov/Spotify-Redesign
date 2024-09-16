import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorConst.instance.white,
    textTheme: TextTheme(
      headlineSmall: FontStyleConst.instance.small,
      headlineMedium: FontStyleConst.instance.medium,
      headlineLarge: FontStyleConst.instance.large,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConst.instance.white,
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorConst.instance.backgroundDark,
    textTheme: TextTheme(
      headlineSmall: FontStyleConst.instance.small.copyWith(color: ColorConst.instance.white),
      headlineMedium: FontStyleConst.instance.medium.copyWith(color: ColorConst.instance.white),
      headlineLarge: FontStyleConst.instance.large.copyWith(color: ColorConst.instance.white),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConst.instance.backgroundDark,
    ),
  );
}
