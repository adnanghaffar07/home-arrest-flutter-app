import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/alerts_model.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/global_widgets/image_pickers/custom_image.dart';
import 'package:home_arrest/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../mixins/appbar_mixin.dart';

class AlertDetailScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/alert-detail-screen';

  final AlertsModel? alertsModel;
  const AlertDetailScreen({super.key, this.alertsModel});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Alerts',
          backgroundColor: Colors.transparent,
          titleColor: const Color.fromARGB(255, 8, 8, 10),
          leadingWidget: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(13),
                child: const Center(child: Icon(Icons.arrow_back_ios, color: Color(0xFF21356A))),
              ),
            );
          }),
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(Icons.search, color: Color(0xFF21356A), size: 25),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              CustomImage(image: alertsModel?.profilePic, height: 50, width: 50),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${alertsModel?.fullName}', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                    Text(
                      'Alert Date: ${DateFormat('dd MMM y').format(alertsModel!.timestamp!)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                    Text(
                      'Time: ${DateFormat('hh:mm a').format(alertsModel!.timestamp!)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
