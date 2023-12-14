// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_arrest/data/model/offender_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/drawer/drawer.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/image_pickers/image_picker_widget.dart';
import '../../../global_widgets/text_fields/underline_input_feild.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../providers/client_provider.dart';
import '../../../utils/utils.dart';
import 'global_widgets/buttons/elevated_button.dart';
import 'view/client/add_offender/widgets/check_in_bottom_sheet.dart';
import 'view/client/add_offender/widgets/client_type_bottom_sheet.dart';
import 'view/client/add_offender/widgets/monitor_level_bottom_sheet.dart';

class WorkScreen extends StatefulWidget {
  static const String routeName = '/WorkScreen';

  final bool isFromNav;
  const WorkScreen({super.key, this.isFromNav = true});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> with AppbarMixin {
  TextEditingController clientTypeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController maidenNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController sentenceStartDateController = TextEditingController();
  TextEditingController sentenceEndDateController = TextEditingController();
  TextEditingController checkInsController = TextEditingController();
  TextEditingController monitorLevelController = TextEditingController();
  TextEditingController workAddress = TextEditingController();
  TextEditingController workCity = TextEditingController();
  TextEditingController workCountry = TextEditingController();
  TextEditingController workStates = TextEditingController();
  TextEditingController workCounty = TextEditingController();
  TextEditingController workProvince = TextEditingController();
  TextEditingController workPostalCode = TextEditingController();
  TextEditingController workLatitude = TextEditingController();
  TextEditingController workLongitude = TextEditingController();
  TextEditingController workRadius = TextEditingController();
  TextEditingController workPhoneNumber = TextEditingController();
  TextEditingController emplyerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ClientProvider>(context, listen: false).clearOffendorImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, child) {
        return GlobalScaffold(
          child: Scaffold(
            drawer: widget.isFromNav ? const HomeDrawer() : null,
            backgroundColor: const Color(0xFF21356A),
            appBar: baseStyleAppBar(
              title: 'Work',
              backgroundColor: Colors.transparent,
              leadingWidget: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(13),
                    child: Center(child: Image.asset(ImagesConstants.menu, color: Colors.white)),
                  ),
                );
              }),
              actions: [
                InkWell(
                  onTap: () {
                    if (!clientProvider.isLoading) {
                      if (clientProvider.pickedFile == null) {
                        Utils.showToast(context, 'Please select profile image');
                        return;
                      } else if (clientTypeController.text.isEmpty) {
                        Utils.showToast(context, 'Please select client type');
                        return;
                      } else if (firstNameController.text.isEmpty) {
                        Utils.showToast(context, 'Please enter first name');
                        return;
                      } else if (lastNameController.text.isEmpty) {
                        Utils.showToast(context, 'Please enter last name');
                        return;
                      } else if (dobController.text.isEmpty) {
                        Utils.showToast(context, 'Please select DOB');
                        return;
                      } else if (ssnController.text.isEmpty) {
                        Utils.showToast(context, 'Please enter SSN');
                        return;
                      } else if (phoneNumberController.text.isEmpty) {
                        Utils.showToast(context, 'Please enter phone number');
                        return;
                      } else if (emailAddressController.text.isEmpty) {
                        Utils.showToast(context, 'Please enter email address');
                        return;
                      } else if (sentenceStartDateController.text.isEmpty) {
                        Utils.showToast(context, 'Please select sentence start date');
                        return;
                      } else if (sentenceEndDateController.text.isEmpty) {
                        Utils.showToast(context, 'Please select sentence end date');
                        return;
                      } else if (checkInsController.text.isEmpty) {
                        Utils.showToast(context, 'Please select check ins');
                        return;
                      } else if (monitorLevelController.text.isEmpty) {
                        Utils.showToast(context, 'Please select monitor level');
                        return;
                      } else {
                        OffendorModel offendorModel = OffendorModel(
                          clientType: clientTypeController.text,
                          firstName: firstNameController.text,
                          middleName: middleNameController.text,
                          lastName: lastNameController.text,
                          maidenName: maidenNameController.text,
                          ssn: ssnController.text,
                          phoneNumber: phoneNumberController.text,
                          emailAddress: emailAddressController.text,
                          sentenceStartDate: sentenceStartDateController.text,
                          sentenceEndDate: sentenceEndDateController.text,
                          monitorLevel: monitorLevelController.text,
                          dateOfBirth: dobController.text,
                          checkIn: checkInsController.text,
                        );
                        clientProvider.addOffendor(offendorModel, context);
                      }
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: clientProvider.isLoading
                        ? const Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Color(0xFF21356A), strokeWidth: 2)))
                        : const Icon(Icons.check, color: Color(0xFF21356A), size: 20),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 75),
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(width: 2, color: Theme.of(context).cardColor),
                      //     shape: BoxShape.circle,
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: ImagePickerWidget(
                      //     image: '',
                      //     onTap: () async {
                      //       clientProvider.pickOffendorImage();
                      //     },
                      //     rawFile: clientProvider.rawFile,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                UnderLineInputTextField(
                  label: 'Work Address',
                  controller: workAddress,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Address',
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
                  label: 'Work City',
                  controller: workCity,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work City',
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
                  label: 'Work Country',
                  controller: workCountry,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Country',
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
                  label: 'Work States',
                  controller: workStates,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work States',
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
                  label: 'Work County',
                  controller: workCounty,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work County',
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
                  label: 'Work Province',
                  controller: workProvince,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Province',
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
                  label: 'Work Postal Code',
                  controller: workPostalCode,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Postal Code',
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
                  label: 'Work Latitude',
                  controller: workLatitude,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Latitude',
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
                  label: 'Work Longitude',
                  controller: workLongitude,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Work Longitude',
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
                  label: 'Work Radius',
                  controller: workRadius,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Radius',
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
                  label: 'Work Phone Number',
                  controller: workPhoneNumber,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Work Phone Number',
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
                  label: 'Employer Name',
                  controller: emplyerName,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFA4A1A1)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onTap: () {},
                        title: Text(
                          'Add Signature',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomElevatedButton(
                        onTap: () {},
                        title: Text(
                          'Face Recognition',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
