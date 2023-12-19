import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CheckInHistoryCell extends StatelessWidget {
  const CheckInHistoryCell({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adnan Gaffar:',
                    style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text('Req:15 Jan 2023 00:16:48', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
                  Text('C/I:15 Jan 2023 00:17:10', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
                  Text('Voluntary check-in request', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
                ],
              ),
            ),
            const Icon(Icons.verified, color: Colors.green, size: 30),
          ],
        ),
      ),
    );
  }
}
