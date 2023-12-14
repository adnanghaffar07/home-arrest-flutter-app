import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/text_fields/input_text_field.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change_password';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with AppbarMixin {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isoldShowPass = false;
  bool isNewShowPass = false;
  bool isConfirmShowPass = false;
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF21356A),
            appBar: baseStyleAppBar(
              title: 'Change Password',
              backgroundColor: Colors.transparent,
              leadingWidget: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.adaptive.arrow_back, color: Colors.white),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    if (oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty) {
                      if (newPasswordController.text == confirmPasswordController.text) {
                        authProvider.changePassword(
                          context,
                          oldPass: oldPasswordController.text,
                          newPass: newPasswordController.text,
                        );
                      } else {
                        Utils.showErrorToast(context, 'New password and confirm password does not match');
                      }
                    } else {
                      Utils.showErrorToast(context, 'Please fill in all feilds');
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: authProvider.isLoginLoading
                        ? const Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Color(0xFF21356A), strokeWidth: 2)))
                        : const Icon(Icons.check, color: Color(0xFF21356A), size: 20),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    InputTextField(
                      obscureText: !isoldShowPass,
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Old Password',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isoldShowPass = !isoldShowPass;
                            });
                          },
                          icon: Icon(isoldShowPass ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600], size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputTextField(
                      controller: newPasswordController,
                      obscureText: !isNewShowPass,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isNewShowPass = !isNewShowPass;
                            });
                          },
                          icon: Icon(isNewShowPass ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600], size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputTextField(
                      controller: confirmPasswordController,
                      obscureText: !isConfirmShowPass,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmShowPass = !isConfirmShowPass;
                            });
                          },
                          icon: Icon(isConfirmShowPass ? Icons.visibility_off : Icons.visibility, color: Colors.grey[600], size: 20),
                        ),
                      ),
                    ),
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
