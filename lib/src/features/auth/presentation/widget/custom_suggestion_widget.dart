import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/core/utils/firebase_service.dart';
import 'package:spotify/src/features/navbar/presentation/page/navbar.dart';

class CustomSuggestionWidget extends StatelessWidget {
  const CustomSuggestionWidget({
    super.key,
    required this.title,
    required this.suggestion,
    required this.onTap,
  });

  final String title;
  final String suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Expanded(
                  child: Divider(
                endIndent: context.getWidth * 0.1,
              )),
              Text('Or', style: context.textMedium),
              Expanded(child: Divider(indent: context.getWidth * 0.1)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  try {
                    await FirebaseService.instance.signInWithGoogle().then((val) {
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Navbar()), (_) => false);
                      }
                    });
                  } catch (e) {
                    if (context.mounted) {
                      context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Failed sign in with Google');
                    }
                  }
                },
                icon: SvgPicture.asset(AppVectors.instance.google)),
            const SizedBox(width: 30),
            IconButton(
              iconSize: 40,
              onPressed: () {
                FirebaseService.instance.signInWithFacebook(context);
              },
              icon: Icon(
                Icons.facebook,
                color: ColorConst.instance.blue,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 25),
          child: RichText(
            text: TextSpan(
              text: title,
              style: context.textMedium,
              children: <InlineSpan>[
                TextSpan(text: suggestion, style: context.textMedium!.copyWith(color: ColorConst.instance.lightGreen), recognizer: TapGestureRecognizer()..onTap = onTap),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
