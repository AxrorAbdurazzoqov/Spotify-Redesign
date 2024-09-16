import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';

extension CheckTheme on BuildContext {
  bool get isLight => AdaptiveTheme.of(this).mode == AdaptiveThemeMode.light;
  bool get isDark => AdaptiveTheme.of(this).mode == AdaptiveThemeMode.dark;
}