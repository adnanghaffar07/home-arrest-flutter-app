import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/alerts_model.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

class AlertsCell extends StatelessWidget {
  final AlertsModel? obj;
  const AlertsCell({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${obj?.fullName}', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                Text(
                  '${obj?.description}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF21356A), size: 15),
                Text(
                  DateFormat('dd MMM, hh:mm a').format(obj!.timestamp!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
