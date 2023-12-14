import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/offender_model.dart';

import '../../../../global_widgets/image_pickers/custom_image.dart';
import '../../../../utils/utils.dart';
import '../../client_history/client_history_screen.dart';
import '../../client_location/widget/client_location_expandable_cell.dart';

class CLientDashboardDetailWidget extends StatelessWidget {
  final OffendorModel offendorModel;
  const CLientDashboardDetailWidget({super.key, required this.offendorModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _borderedContainer(
            title: 'Client Location',
            icon: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ClientHistoryScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.map_outlined, color: Color(0xFF21356A), size: 20),
              ),
            ),
            view: Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset('assets/images/map.png', fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: List.generate(5, (index) {
              switch (index) {
                case 0:
                  return ClientLocationExpandableCell(
                    title: 'Summary',
                    expandedHeight: 470,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CustomImage(image: offendorModel.profilePic ?? '', height: 50, width: 50, fit: BoxFit.fill),
                            ),
                            const SizedBox(width: 20),
                            Text('${offendorModel.firstName} ${offendorModel.lastName}', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'PHONE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${offendorModel.phoneNumber}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'EMAIL',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${offendorModel.emailAddress}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'HOME ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${offendorModel.workAddressDetails?.workAddress}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'WORK ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${offendorModel.homeAddressDetails?.homeAddress}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'SPECIAL INSTRUCTIONS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Lacus cras congue molestie sit ut quis arcu. Et et nullam lacus eu in. Magna semper massa bibendum lacinia felis iaculis diam. At tincidunt nunc urna massa enim senectus commodo magna.',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                case 1:
                  return ClientLocationExpandableCell(
                    title: 'Scorecard',
                    expandedHeight: 325,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MONITORING PERIOD',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '20-03-2023',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'TOTAL CHEKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '167',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'OUTSTANDING',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '73',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'LATE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '30',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'VOLUNTARY CHECKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '123',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                case 2:
                  return ClientLocationExpandableCell(
                    title: 'Recent Alerts',
                    expandedHeight: 325,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MONITORING PERIOD',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '20-03-2023',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'TOTAL CHEKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '167',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'OUTSTANDING',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '73',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'LATE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '30',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'VOLUNTARY CHECKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '123',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                case 3:
                  return ClientLocationExpandableCell(
                    title: 'Court Appearance',
                    expandedHeight: 325,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MONITORING PERIOD',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '20-03-2023',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'TOTAL CHEKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '167',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'OUTSTANDING',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '73',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'LATE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '30',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'VOLUNTARY CHECKINS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '123',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                case 4:
                  return ClientLocationExpandableCell(
                    title: 'Report',
                    expandedHeight: 387,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _reportCell(title: 'Client Report', description: 'Shows Client check-ins, alerts and locations visited', icon: Icons.assessment_outlined),
                        const SizedBox(height: 15),
                        _reportCell(title: 'late check-ins', description: 'Show late check-ins (5 minutes late)', icon: Icons.warning_outlined),
                        const SizedBox(height: 15),
                        _reportCell(title: 'late sobriety check-ins', description: 'Show late sobriety check-ins (1 hour late)', icon: Icons.location_disabled_outlined),
                        const SizedBox(height: 15),
                        _reportCell(title: 'map history', description: 'Show location history on a map', icon: Icons.location_on_outlined),
                        const SizedBox(height: 15),
                        _reportCell(title: 'heatmap', description: 'show frequently visited locations on a map', icon: Icons.apartment),
                      ],
                    ),
                  );
                default:
                  return Container();
              }
            }),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Row _reportCell({String title = '', description = '', IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF21356A),
          size: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
              ),
              Text(
                description,
                style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _borderedContainer({String? title, Widget? icon, Widget? view}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? '',
                  style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                ),
                icon ?? const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
          const SizedBox(height: 15),
          view ?? const SizedBox(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
