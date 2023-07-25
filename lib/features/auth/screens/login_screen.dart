import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/auth/controller/auth_controller.dart';
import 'package:taqyeemi/features/auth/screens/signup_screen.dart';
import 'package:taqyeemi/features/auth/screens/widgets/auth_button.dart';
import 'package:taqyeemi/features/auth/screens/widgets/custom_password_field.dart';
import 'package:taqyeemi/features/auth/screens/widgets/custom_text_field.dart';

import '../../../core/core.dart';
import '../../../theme/pallete.dart';
import 'widgets/google_login_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const String routeName = "/sign_in_screen";
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void signInWithEmail(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context);
    }
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              "Welcome Back!",
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
              "please sign in to your account",
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
                      controller: _emailController,
                      validator: emailValidator,
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomPasswordField(
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      alignment: Alignment.topRight,
                      child: const Text("Forget Password?",
                          style: TextStyle(
                            color: Pallete.greyColor,
                            fontSize: 14,
                          )),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    AuthButton(
                      onPressed: signInWithEmail,
                      text: "Sign In",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const GoogleLoginButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () => navigateToSignUpScreen(context),
                          child: const Text(
                            "Sign Up",
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
          ]),
        ),
      ),
    ));
  }
}
