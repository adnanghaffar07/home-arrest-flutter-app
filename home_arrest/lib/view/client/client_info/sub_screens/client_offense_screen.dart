// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_arrest/data/model/offender_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../constants/image_constants.dart';
import '../../../../global_widgets/buttons/elevated_button.dart';
import '../../../../global_widgets/drawer/drawer.dart';
import '../../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../../global_widgets/text_fields/underline_input_feild.dart';
import '../../../../mixins/appbar_mixin.dart';
import '../../../../providers/client_provider.dart';
import '../../../../utils/utils.dart';

class ClientOffenseDetailsScreen extends StatefulWidget {
  static const String routeName = '/clientOffenseDetailsScreen';

  final bool isFromNav;
  const ClientOffenseDetailsScreen({super.key, this.isFromNav = true});

  @override
  State<ClientOffenseDetailsScreen> createState() => _ClientOffenseDetailsScreenState();
}

class _ClientOffenseDetailsScreenState extends State<ClientOffenseDetailsScreen> with AppbarMixin {
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
  TextEditingController appearanceDate = TextEditingController();
  TextEditingController appearanceTime = TextEditingController();
  TextEditingController specialInstruction = TextEditingController();
  TextEditingController monitoringFrequency = TextEditingController();
  TextEditingController sentenceStart = TextEditingController();
  TextEditingController sentenceEnd = TextEditingController();
  TextEditingController monitorTime = TextEditingController();
  bool pictureCheck = false;
  bool videoCheck = false;
  bool soberityCheck = false;
  bool scheduleOnly = false;
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
              title: 'Offense',
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(
                  onTap: () {},
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
                    children: const [
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Appearance Date',
                        controller: appearanceDate,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Appearance Date',
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
                        label: 'Appearance Time',
                        controller: appearanceTime,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        keyboardType: TextInputType.number,
                        isRequired: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Appearance Time',
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
                  label: 'Speacial Instruction',
                  controller: specialInstruction,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Speacial Instruction',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Monitoring Frequency',
                  controller: monitoringFrequency,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Monitoring Frequency',
                    hintStyle: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFA4A1A1))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: UnderLineInputTextField(
                        label: 'Sentence Start',
                        controller: sentenceStart,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter starting Date',
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
                        label: 'Sentence End',
                        controller: sentenceEnd,
                        labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                        isRequired: true,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Ending Date',
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
                  ],
                ),
                const SizedBox(height: 20),
                UnderLineInputTextField(
                  label: 'Monitor Time',
                  controller: monitorTime,
                  labelStyle: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFFA4A1A1)),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Monitor Time',
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
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Photo Check-in',
                      style: TextStyle(color: Colors.white),
                    )),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: Colors.green,
                        // color of the round icon, which moves from right to left
                        thumbColor: Colors.white,
                        // when the switch is off
                        trackColor: Colors.black12,
                        // boolean variable value
                        value: pictureCheck,
                        // changes the state of the switch
                        onChanged: (value) => setState(() => pictureCheck = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                  height: 0.9,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Video Check-in',
                      style: TextStyle(color: Colors.white),
                    )),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: Colors.green,
                        // color of the round icon, which moves from right to left
                        thumbColor: Colors.white,
                        // when the switch is off
                        trackColor: Colors.black12,
                        // boolean variable value
                        value: videoCheck,
                        // changes the state of the switch
                        onChanged: (value) => setState(() => videoCheck = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                  height: 0.9,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Sobritey Check-in',
                      style: TextStyle(color: Colors.white),
                    )),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: Colors.green,
                        // color of the round icon, which moves from right to left
                        thumbColor: Colors.white,
                        // when the switch is off
                        trackColor: Colors.black12,
                        // boolean variable value
                        value: soberityCheck,
                        // changes the state of the switch
                        onChanged: (value) => setState(() => soberityCheck = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                  height: 0.9,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Main Schedule ONLY',
                      style: TextStyle(color: Colors.white),
                    )),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: Colors.green,
                        // color of the round icon, which moves from right to left
                        thumbColor: Colors.white,
                        // when the switch is off
                        trackColor: Colors.black12,
                        // boolean variable value
                        value: scheduleOnly,
                        // changes the state of the switch
                        onChanged: (value) => setState(() => scheduleOnly = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                  height: 0.9,
                  thickness: 1,
                ),
                const SizedBox(height: 40),
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
