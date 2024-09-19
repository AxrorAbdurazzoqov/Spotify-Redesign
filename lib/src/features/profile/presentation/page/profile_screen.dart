import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/features/auth/presentation/page/register_signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile', style: context.textLarge),
        actions: [
          IconButton(
            onPressed: () {
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
            },
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: context.isDark ? ColorConst.instance.white : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            height: context.getHeight * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.isDark ? ColorConst.instance.backgroundDark : ColorConst.instance.white,
              boxShadow: [
                BoxShadow(
                  color: context.isLight ? ColorConst.instance.backgroundDark : ColorConst.instance.white,
                  blurRadius: 20,
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: context.getHeight * 0.05,
                      foregroundImage: NetworkImage(user!.photoURL ?? 'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png'),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -25,
                      child: IconButton(onPressed: () {}, icon: Icon(Icons.edit_square, color: context.isDark ? ColorConst.instance.white : ColorConst.instance.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(user!.email ?? '', style: FontStyleConst.instance.medium.copyWith(color: ColorConst.instance.grey)),
                Expanded(
                  child: Text(
                    user!.displayName ?? 'Guest',
                    style: context.textLarge,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '778\n',
                        style: context.textLarge,
                        children: [
                          TextSpan(
                            text: 'Followers',
                            style: context.textMedium!.copyWith(color: ColorConst.instance.grey),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '778\n',
                        style: context.textLarge,
                        children: [
                          TextSpan(
                            text: 'Following',
                            style: context.textMedium!.copyWith(color: ColorConst.instance.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
