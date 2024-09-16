import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title,
    this.borderRadius = 30,
    required this.height,
    required this.width,
    this.fontSize = 22,
    this.color,
  });

  final VoidCallback onTap;
  final String title;
  final double borderRadius;
  final double height;
  final double width;
  final double fontSize;
  final int? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
        fixedSize: WidgetStatePropertyAll(Size(width, height)),
        backgroundColor: WidgetStatePropertyAll(color == null ? ColorConst.instance.lightGreen : Color(color!)),
        foregroundColor: WidgetStatePropertyAll(ColorConst.instance.white),
      ),
      child: Text(title, style: context.textMedium!.copyWith(fontSize: fontSize, fontWeight: FontWeight.bold)),
    );
  }
}