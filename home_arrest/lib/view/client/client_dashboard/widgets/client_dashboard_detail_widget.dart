// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:home_arrest/data/model/offender_model.dart';

import '../../../../global_widgets/image_pickers/custom_image.dart';
import '../../../../utils/utils.dart';
import '../../client_history/client_history_screen.dart';
import '../../client_location/widget/client_location_expandable_cell.dart';

class CLientDashboardDetailWidget extends StatefulWidget {
  final OffendorModel offendorModel;
  const CLientDashboardDetailWidget({
    Key? key,
    required this.offendorModel,
  }) : super(key: key);

  @override
  State<CLientDashboardDetailWidget> createState() => _CLientDashboardDetailWidgetState();
}

class _CLientDashboardDetailWidgetState extends State<CLientDashboardDetailWidget> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(bearing: 192.8334901395799, target: LatLng(37.43296265331129, -122.08832357078792), tilt: 59.440717697143555, zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _borderedContainer(
            title: 'Client Current Location',
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
              height: 350,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GoogleMap(
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: List.generate(5, (index) {
              switch (index) {
                case 0:
                  return ClientLocationExpandableCell(
                    title: 'Client Summary',
                    expandedHeight: 470,
                    data: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CustomImage(image: widget.offendorModel.profilePic ?? '', height: 50, width: 50, fit: BoxFit.fill),
                            ),
                            const SizedBox(width: 20),
                            Text('${widget.offendorModel.firstName} ${widget.offendorModel.lastName}',
                                style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'PHONE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${widget.offendorModel.phoneNumber}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'EMAIL',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '${widget.offendorModel.emailAddress}',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'HOME ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          widget.offendorModel.contactDetails?.homeAddress ?? '',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'WORK ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          widget.offendorModel.workDetails?.workAddress ?? '',
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
                  style: Utils.safeGoogleFont('Poppins', fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
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
