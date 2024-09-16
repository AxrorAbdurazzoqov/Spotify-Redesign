import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/features/auth/presentation/page/register_signin_screen.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({super.key});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          height: context.getHeight * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.isDark ? ColorConst.instance.backgroundDark : ColorConst.instance.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: ColorConst.instance.lightGreen,
                  ),
                  const SizedBox(width: 30),
                  Text('Axror Abdurazzoqov', style: context.textMedium),
                ],
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  CupertinoIcons.moon_stars,
                  color: context.isDark ? ColorConst.instance.white : ColorConst.instance.grey,
                  size: 32,
                ),
                title: Text(
                  'Dark mode',
                  style: context.textMedium,
                ),
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = !isDark;
                      isDark ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
                    });
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut().then(
                    (val) {
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RegisterSignInScreen()), (_) => false);
                      }
                    },
                    onError: (val) {
                      if (context.mounted) {
                        context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Failed to Sign Out!');
                      }
                    },
                  );
                },
                leading: Icon(CupertinoIcons.square_arrow_left, color: ColorConst.instance.red),
                title: Text(
                  'Sign Out',
                  style: context.textMedium!.copyWith(color: ColorConst.instance.red),
                ),
              ),
            ],
          ),
        );
      },
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: context.getHeight * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDark ? ColorConst.instance.backgroundDark : ColorConst.instance.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: ColorConst.instance.lightGreen,
              ),
              const SizedBox(width: 30),
              Text('Axror Abdurazzoqov', style: context.textMedium),
            ],
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              CupertinoIcons.moon_stars,
              color: context.isDark ? ColorConst.instance.white : ColorConst.instance.grey,
              size: 32,
            ),
            title: Text(
              'Dark mode',
              style: context.textMedium,
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                isDark = !isDark;
                isDark ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
              },
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                (val) {
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RegisterSignInScreen()), (_) => false);
                  }
                },
                onError: (val) {
                  if (context.mounted) {
                    context.showCustomSnackBar(color: ColorConst.instance.red, title: 'Failed to Sign Out!');
                  }
                },
              );
            },
            leading: Icon(CupertinoIcons.square_arrow_left, color: ColorConst.instance.red),
            title: Text(
              'Sign Out',
              style: context.textMedium!.copyWith(color: ColorConst.instance.red),
            ),
          ),
        ],
      ),
    );
  }
}
