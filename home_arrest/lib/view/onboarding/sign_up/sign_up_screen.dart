import 'package:flutter/material.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/buttons/elevated_button.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/text_fields/input_text_field.dart';
import '../../../utils/utils.dart';
import '../../client/client_details/client_details.dart';

class SignUpScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/sign_up';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: '',
          backgroundColor: Colors.transparent,
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back, color: Color(0xFF21356A)),
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
                const InputTextField(
                  decoration: InputDecoration(
                    hintText: ' Email address / Phone number',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                const InputTextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                const InputTextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'QR code',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.qr_code, size: 20, color: Color(0xFF21356A)),
                  ),
                ),
                const SizedBox(height: 50),
                CustomElevatedButton(
                  onTap: () {
                    Navigator.pushNamed(context, ClientDetailsScreen.routeName);
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
      ),
    );
  }
}
