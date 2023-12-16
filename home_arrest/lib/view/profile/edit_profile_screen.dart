
import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/admin_user_model.dart';
import 'package:home_arrest/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/image_pickers/image_picker_widget.dart';
import '../../global_widgets/text_fields/underline_input_feild.dart';
import '../../mixins/appbar_mixin.dart';
import '../../utils/utils.dart';
import 'widgets/gender_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';

  final AdminUserModel? user;
  const EditProfileScreen({super.key, this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with AppbarMixin {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).clearUserImage();
      if (widget.user!.firstName != null) firstNameController.text = widget.user!.firstName!;
      if (widget.user!.lastName != null) lastNameController.text = widget.user!.lastName!;
      if (widget.user!.email != null) emailController.text = widget.user!.email!;
      if (widget.user!.phoneNumber != null) phoneNumberController.text = widget.user!.phoneNumber!;
      if (widget.user!.gender != null) genderController.text = widget.user!.gender!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF21356A),
          appBar: baseStyleAppBar(
            title: 'Edit Profile',
            backgroundColor: Colors.transparent,
            actions: [
              InkWell(
                onTap: () {
                  if (!userProvider.isLoading) {
                    if (firstNameController.text.isEmpty) {
                      Utils.showToast(context, 'Please enter first name');
                      return;
                    } else if (lastNameController.text.isEmpty) {
                      Utils.showToast(context, 'Please enter last name');
                      return;
                    } else if (phoneNumberController.text.isEmpty) {
                      Utils.showToast(context, 'Please enter phone number');
                      return;
                    } else if (emailController.text.isEmpty) {
                      Utils.showToast(context, 'Please enter email address');
                      return;
                    } else if (genderController.text.isEmpty) {
                      Utils.showToast(context, 'Please select gender');
                      return;
                    } else {
                      AdminUserModel model = AdminUserModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        gender: genderController.text,
                        phoneNumber: phoneNumberController.text,
                      );
                      userProvider.updateUser(model, context);
                    }
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: userProvider.isLoading
                      ? const Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Color(0xFF21356A), strokeWidth: 2)))
                      : const Icon(Icons.check, color: Color(0xFF21356A), size: 20),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Theme.of(context).cardColor),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: ImagePickerWidget(
                          image: widget.user?.profilePic ?? '',
                          onTap: () async {
                            userProvider.pickUserImage();
                          },
                          rawFile: userProvider.rawFile,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Fist Name',
                        controller: firstNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        decoration: InputDecoration(
                          hintText: 'Enter Fist Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Last Name',
                        controller: lastNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Email Address',
                  controller: emailController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA4A1A1)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Phone Number',
                  controller: phoneNumberController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Number',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA4A1A1)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Gender',
                  controller: genderController,
                  enabled: false,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  decoration: InputDecoration(
                    hintText: 'Tap to choose',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    suffixIcon: const Icon(Icons.expand_more, color: Colors.white),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => GenderBottomSheet(
                        onTap: (index) {
                          genderController.text = userProvider.selectGender(index);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
