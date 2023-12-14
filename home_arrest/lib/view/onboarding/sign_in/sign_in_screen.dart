import 'package:flutter/material.dart';
import 'package:home_arrest/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/buttons/elevated_button.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/text_fields/input_text_field.dart';
import '../../../utils/utils.dart';

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
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Scaffold(
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
                      style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                    ),
                    Text(
                      'without Ankle Bracelets!',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF21356A)),
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
                      obscureText: isShowPassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                          icon: Icon(!isShowPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600], size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFF21356A),
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
                      isLoading: authProvider.isLoginLoading,
                      onTap: () {
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          Utils.showToast(context, 'Please enter email and password', backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
                          return;
                        }
                        authProvider.login(context, email: emailController.text, password: passwordController.text);
                      },
                      title: Text(
                        'Sign in',
                        style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomElevatedButton(
                      onTap: () {
                        // Navigator.pushNamed(context, SignUpScreen.routeName);
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
          );
        },
      ),
    );
  }
}
