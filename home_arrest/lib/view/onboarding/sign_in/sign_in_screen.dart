import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_arrest/view/client/client_details/client_details.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/buttons/elevated_button.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/text_fields/input_text_field.dart';
import '../../../utils/utils.dart';
import '../../dashboard/dashboard_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign_in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(ImagesConstants.logo, width: 80),
                const SizedBox(height: 40),
                Text(
                  'More effective & complete electronic monitoring',
                  style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Text(
                  'without Ankle Bracelets!',
                  style: Utils.safeGoogleFont('Poppins', fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 40),
                InputTextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'User name /  Email address',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                InputTextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      value: isRememberMe,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = value!;
                        });
                      },
                    ),
                    Text(
                      'Remember me',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  onTap: () {
                    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                      Utils.showToast(context, 'Please enter email and password', backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
                      return;
                    } else if (emailController.text != 'adnan@codeautomation.ai') {
                      Utils.showToast(context, 'Email Doesn\'t exist', backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
                      return;
                    }
                    Navigator.pushNamed(context, DashboardScreen.routeName);
                  },
                  title: Text(
                    'Sign in',
                    style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                CustomElevatedButton(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  unPressColor: const Color(0xFFDFDFDF),
                  pressColor: const Color(0xFFDFDFDF).withOpacity(0.8),
                  title: Text(
                    'Sign up',
                    style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF9F9F9F)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
