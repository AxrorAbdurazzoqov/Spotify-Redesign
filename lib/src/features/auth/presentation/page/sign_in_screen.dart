import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/core/utils/app_validators.dart';
import 'package:spotify/src/core/utils/firebase_service.dart';
import 'package:spotify/src/core/widget/custom_elevated_button.dart';
import 'package:spotify/src/features/auth/presentation/page/register_screen.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_app_bar.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_suggestion_widget.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_support_rich_text.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElasticInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'Sign In',
                      style: context.textLarge!.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 38),
                    child: ElasticInUp(
                      delay: const Duration(milliseconds: 500),
                      child: const CustomSupportRichText(),
                    ),
                  ),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        ElasticInRight(
                          delay: const Duration(milliseconds: 550),
                          child: CustomTextFormField(controller: _emailController, hinText: 'Enter Username or Email', validator: AppValidators.usernameOrEmail),
                        ),
                        const SizedBox(height: 10),
                        ElasticInRight(
                          delay: const Duration(milliseconds: 750),
                          child: CustomTextFormField(controller: _passwordController, hinText: 'Password', isSecured: true, textInputAction: TextInputAction.done, validator: AppValidators.password),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElasticInLeft(
                      delay: const Duration(milliseconds: 1200),
                      child: TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                            context.showCustomSnackBar(color: ColorConst.instance.blue, title: 'check email and set new password via link');
                          },
                          child: Text(
                            'Reset Password',
                            style: context.textMedium!.copyWith(decoration: TextDecoration.underline),
                          )),
                    ),
                  ),
                  const SizedBox(height: 39),
                  CustomElevatedButton(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                          FirebaseService.instance.signInWithEmail(email: _emailController.text, password: _passwordController.text, context: context);
                        }
                      },
                      title: 'Sign In',
                      height: context.getHeight * 0.1,
                      width: context.getWidth),
                  BounceInUp(
                    child: CustomSuggestionWidget(
                      title: 'Not a Memeber?\t',
                      suggestion: 'Register Now',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
