import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/get_mediaquery_heigh_width.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';
import 'package:spotify/src/core/extensions/show_custom_snack_bar.dart';
import 'package:spotify/src/core/utils/app_validators.dart';
import 'package:spotify/src/core/utils/firebase_service.dart';
import 'package:spotify/src/core/widget/custom_elevated_button.dart';
import 'package:spotify/src/features/auth/presentation/page/sign_in_screen.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_app_bar.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_suggestion_widget.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_support_rich_text.dart';
import 'package:spotify/src/features/auth/presentation/widget/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
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
                  const SizedBox(height: 18),
                  BounceInDown(
                    delay: const Duration(milliseconds: 300),
                    child: Text('Register', style: context.textLarge!.copyWith(fontSize: 40, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 38),
                    child: BounceInDown(
                      delay: const Duration(milliseconds: 500),
                      child: CustomSupportRichText(
                        onError: () => context.showCustomSnackBar(title: 'Something went wrong', color: ColorConst.instance.red),
                      ),
                    ),
                  ),
                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        BounceInDown(
                          delay: const Duration(milliseconds: 200),
                          child: CustomTextFormField(controller: _fullNameController, hinText: 'Full Name', validator: AppValidators.name),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 350),
                          child: CustomTextFormField(controller: _emailController, hinText: 'Enter Email', validator: AppValidators.email),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 500),
                          child: CustomTextFormField(controller: _usernameController, hinText: 'Enter Username', validator: AppValidators.name),
                        ),
                        const SizedBox(height: 10),
                        BounceInDown(
                          delay: const Duration(milliseconds: 750),
                          child: CustomTextFormField(controller: _passwordController, hinText: 'Password', isSecured: true, textInputAction: TextInputAction.done, validator: AppValidators.password),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                          FirebaseService.instance.createAccountWithEmail(email: _emailController.text, password: _passwordController.text, context: context, username: _usernameController.text);
                        }
                      },
                      title: 'Create Account',
                      height: context.getHeight * 0.1,
                      width: context.getWidth),
                  BounceInUp(
                    child: CustomSuggestionWidget(
                      title: 'Do You Have An Account?\t',
                      suggestion: 'Sign In',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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
