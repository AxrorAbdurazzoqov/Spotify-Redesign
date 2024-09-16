import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/widget/custom_elevated_button.dart';
import 'package:spotify/src/features/auth/presentation/page/register_signin_screen.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({super.key});

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppVectors.instance.backgroundImage2), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            Hero(
              tag: 'logo',
              child: Material(
                color: Colors.transparent,
                child: SvgPicture.asset(AppVectors.instance.spotifyLogo),
              ),
            ),
            const Spacer(),
            Text('Choose Mode', style: FontStyleConst.instance.large.copyWith(color: ColorConst.instance.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Bounce(
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      isDarkMode
                          ? SvgPicture.asset(AppVectors.instance.moonSelected)
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: ColorConst.instance.white.withOpacity(0.2),
                              child: IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      isDarkMode = true;
                                      AdaptiveTheme.of(context).setDark();
                                    });
                                  },
                                  icon: Icon(CupertinoIcons.moon, color: ColorConst.instance.white)),
                            ),
                      const SizedBox(height: 10),
                      Text(
                        'Dark Mode',
                        style: context.textMedium!.copyWith(color: ColorConst.instance.white, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Bounce(
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      !isDarkMode
                          ? SvgPicture.asset(AppVectors.instance.sunSelected)
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: ColorConst.instance.white.withOpacity(0.2),
                              child: IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      isDarkMode = false;
                                      AdaptiveTheme.of(context).setLight();
                                    });
                                  },
                                  icon: Icon(CupertinoIcons.sun_min, color: ColorConst.instance.white)),
                            ),
                      const SizedBox(height: 20),
                      Text(
                        'Light Mode',
                        style: context.textMedium!.copyWith(color: ColorConst.instance.white, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ElasticInUp(
                child: CustomElevatedButton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RegisterSignInScreen()), (_) => false);
                  },
                  title: 'Continue',
                  height: 80,
                  width: context.getWidth,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
