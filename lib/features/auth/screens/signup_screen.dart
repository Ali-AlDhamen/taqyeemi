import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../theme/pallete.dart';
import '../controller/auth_controller.dart';
import 'widgets/auth_button.dart';
import 'widgets/custom_password_field.dart';
import 'widgets/custom_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = "/sign_up_screen";

  const SignUpScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void signUpWithEmail(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _fullNameController.text.trim(),
          phoneNumber: _mobileNumberController.text.trim(),
          context: context);
    }
  }

  void navigateToSignInScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    _fullNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Create new account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "please fill in the form to continue",
                style: TextStyle(
                  fontSize: 14,
                  color: Pallete.greyColor,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: "Full Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your full name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          validator: emailValidator),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _mobileNumberController,
                        hintText: "Phone Number",
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone number";
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomPasswordField(
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                
                      AuthButton(
                        onPressed: signUpWithEmail,
                        text: "Sign Up",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an Account?",
                            style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () => navigateToSignInScreen(context),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Pallete.purpleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
