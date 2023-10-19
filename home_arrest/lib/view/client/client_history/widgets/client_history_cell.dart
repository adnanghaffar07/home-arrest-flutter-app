import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/client_history_mode.dart';
import 'package:home_arrest/utils/utils.dart';

class ClientHistoryCell extends StatelessWidget {
  final ClientHistoryModel clientHistoryModel;
  const ClientHistoryCell({super.key, required this.clientHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent[100],
              ),
              child: Center(
                child: Icon(Icons.schedule, color: Colors.green[900], size: 18),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              clientHistoryModel.dateTime,
              style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[700]),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          clientHistoryModel.address,
          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ],
    );
  }
}
