import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/constants/font_style/font_style_const.dart';
import 'package:spotify/src/core/constants/vectors/app_vectors.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/widget/custom_elevated_button.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:spotify/src/features/onboarding/presentation/page/choose_mode_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppVectors.instance.backgroundImage1), fit: BoxFit.cover),
        ),
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Column(
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
                SlideInLeft(
                  duration: const Duration(milliseconds: 1500),
                  child: Text(
                    state.titles[state.index]['title'],
                    style: FontStyleConst.instance.medium.copyWith(fontSize: 25, color: ColorConst.instance.white),
                  ),
                ),
                const SizedBox(height: 21),
                SlideInRight(
                  duration: const Duration(milliseconds: 1500),
                  child: Text(
                    state.titles[state.index]['subtitle'],
                    style: FontStyleConst.instance.medium.copyWith(color: ColorConst.instance.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ElasticInUp(
                    child: CustomElevatedButton(
                      height: 78,
                      width: context.getWidth,
                      title: state.titles.length - 1 != state.index ? 'Next' : 'Get Started',
                      onTap: () {
                        BlocProvider.of<OnboardingBloc>(context).add(
                          OnNextEvent(index: state.index + 1),
                        );
                        if (state.index == state.titles.length - 1) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const ChooseModeScreen()),
                            (_) => false,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
