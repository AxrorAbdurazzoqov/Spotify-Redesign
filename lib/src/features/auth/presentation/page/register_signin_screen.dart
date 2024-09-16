import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/check_theme.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/widget/custom_elevated_button.dart';
import 'package:spotify/src/features/auth/presentation/page/register_screen.dart';
import 'package:spotify/src/features/auth/presentation/page/sign_in_screen.dart';

class RegisterSignInScreen extends StatelessWidget {
  const RegisterSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 146),
                SvgPicture.asset(AppVectors.instance.spotifyLogo),
                const SizedBox(height: 120),
                ElasticInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Text('Enjoy Listening To Music', style: context.textLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 50),
                  child: ElasticInUp(
                    delay: const Duration(milliseconds: 500),
                    child: Text(
                      "Spotify is a proprietary Swedish audio streaming and meda services provider",
                      style: FontStyleConst.instance.small.copyWith(color: ColorConst.instance.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElasticInLeft(
                        delay: const Duration(milliseconds: 1200),
                        child: CustomElevatedButton(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                          },
                          title: 'Register',
                          height: context.getHeight * 0.1,
                          width: context.getWidth,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElasticInRight(
                        delay: const Duration(milliseconds: 1200),
                        child: CustomElevatedButton(
                          onTap: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                          },
                          title: 'Sign In',
                          color: context.isDark ? 0xff1C1B1B : 0xffFFFFFF,
                          height: context.getHeight * 0.1,
                          width: context.getWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: -context.getHeight * 0.2,
              top: -context.getHeight * 0.28,
              child: SvgPicture.asset(
                AppVectors.instance.pattern,
                width: context.getWidth * 0.8,
                colorFilter: ColorFilter.mode(ColorConst.instance.grey, BlendMode.srcIn),
              ),
            ),
            Positioned(
              right: -context.getHeight * 0.13,
              bottom: -context.getHeight * 0.35,
              child: SvgPicture.asset(
                AppVectors.instance.pattern,
                width: context.getWidth,
                colorFilter: ColorFilter.mode(ColorConst.instance.grey, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
