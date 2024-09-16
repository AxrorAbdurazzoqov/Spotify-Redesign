import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hinText,
    this.isSecured = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  final TextEditingController controller;
  final String hinText;
  final bool isSecured;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isSecured;

  @override
  void initState() {
    super.initState();
    isSecured = widget.isSecured;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      style: context.textMedium,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hinText,
        suffixIcon: widget.isSecured
            ? IconButton(
                onPressed: () {
                  isSecured = !isSecured;
                  setState(() {});
                },
                icon: Icon(isSecured ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        hintStyle: FontStyleConst.instance.medium.copyWith(fontWeight: FontWeight.w200, color: ColorConst.instance.grey.withOpacity(0.85)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorConst.instance.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorConst.instance.lightGreen),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorConst.instance.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorConst.instance.red),
        ),
      ),
    );
  }
}
