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
import 'widgets/check_in_bottom_sheet.dart';
import 'widgets/client_type_bottom_sheet.dart';
import 'widgets/monitor_level_bottom_sheet.dart';

class AddOffenderScreen extends StatefulWidget {
  static const String routeName = '/add_offender';

  final bool isFromNav;
  const AddOffenderScreen({super.key, this.isFromNav = true});

  @override
  State<AddOffenderScreen> createState() => _AddOffenderScreenState();
}

class _AddOffenderScreenState extends State<AddOffenderScreen> with AppbarMixin {
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
              title: 'Add Client',
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Theme.of(context).cardColor),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: ImagePickerWidget(
                          image: '',
                          onTap: () async {
                            clientProvider.pickOffendorImage();
                          },
                          rawFile: clientProvider.rawFile,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                UnderLineInputTextField(
                  label: 'Client Type',
                  controller: clientTypeController,
                  enabled: false,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
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
                      builder: (context) => ClientTypeBottomSheet(
                        onTap: (index) {
                          clientTypeController.text = clientProvider.selectClientType(index);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'First Name',
                        controller: firstNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFA4A1A1)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Middle Name',
                        controller: middleNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        decoration: InputDecoration(
                          hintText: 'Enter Middle Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Last Name',
                        controller: lastNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Maiden Name',
                        controller: maidenNameController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        decoration: InputDecoration(
                          hintText: 'Enter Maiden Name',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'DOB',
                        controller: dobController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter DOB',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                          suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 20),
                        ),
                        onTap: () {
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 50000)), lastDate: DateTime.now()).then((value) {
                            if (value != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(value);
                              dobController.text = formattedDate.toString();
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'SSN',
                        controller: ssnController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        decoration: InputDecoration(
                          hintText: 'Enter SSN',
                          hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFA4A1A1)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Phone Number',
                  controller: phoneNumberController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
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
                  label: 'Email Address',
                  controller: emailAddressController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
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
                  label: 'Sentence Start Date',
                  controller: sentenceStartDateController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Date',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 20),
                  ),
                  onTap: () {
                    showDatePicker(
                            context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 10000)), lastDate: DateTime.now().add(const Duration(days: 10000)))
                        .then((value) {
                      if (value != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(value);
                        sentenceStartDateController.text = formattedDate;
                      }
                    });
                    ;
                  },
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Sentence End Date',
                  controller: sentenceEndDateController,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Date',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 20),
                  ),
                  onTap: () {
                    showDatePicker(
                            context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 10000)), lastDate: DateTime.now().add(const Duration(days: 10000)))
                        .then((value) {
                      if (value != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(value);
                        sentenceEndDateController.text = formattedDate;
                      }
                    });
                    ;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Check Ins',
                        controller: checkInsController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
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
                            builder: (context) => CheckInBottomSheet(
                              onTap: (index) {
                                checkInsController.text = clientProvider.setCheckIn(index);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Monitor Level',
                        controller: monitorLevelController,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
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
                            builder: (context) => MonitorLevelBottomSheet(
                              onTap: (index) {
                                monitorLevelController.text = clientProvider.setMonitorLevel(index);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
