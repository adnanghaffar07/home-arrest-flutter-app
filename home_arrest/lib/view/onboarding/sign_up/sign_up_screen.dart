import 'package:flutter/material.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';
import 'package:home_arrest/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/buttons/elevated_button.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/text_fields/input_text_field.dart';
import '../../../utils/utils.dart';

class SignUpScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/sign_up';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController numberController = TextEditingController();

    return GlobalScaffold(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: baseStyleAppBar(
              title: '',
              backgroundColor: Colors.transparent,
              leadingWidget: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(ImagesConstants.logo, width: 80),
                    const SizedBox(height: 40),
                    Text(
                      'Sign Up',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Sign up for House Arrest App now!',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 40),
                    InputTextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputTextField(
                      controller: numberController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputTextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),

                    // const InputTextField(
                    //   obscureText: true,
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     hintText: 'QR code',
                    //     enabledBorder: InputBorder.none,
                    //     focusedBorder: InputBorder.none,
                    //     disabledBorder: InputBorder.none,
                    //     suffixIcon: Icon(Icons.qr_code, size: 20, color: Color(0xFF21356A)),
                    //   ),
                    // ),
                    const SizedBox(height: 50),
                    CustomElevatedButton(
                      isLoading: authProvider.isLoginLoading,
                      onTap: () {
                        if (emailController.text.isEmpty || passwordController.text.isEmpty || numberController.text.isEmpty) {
                          Utils.showToast(context, 'Please Fill All Feilds', backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
                          return;
                        }
                        authProvider.signUp(context, email: emailController.text, password: passwordController.text, number: numberController.text);
                      },
                      title: Text(
                        'Sign up',
                        style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
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
