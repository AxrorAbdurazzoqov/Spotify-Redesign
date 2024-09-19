import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';

extension ShowCustomSnackBar on BuildContext {
  void showCustomSnackBar({required Color color, required String title}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: ColorConst.instance.white,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
