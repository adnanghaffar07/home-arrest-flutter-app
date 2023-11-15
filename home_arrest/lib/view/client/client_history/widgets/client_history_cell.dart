import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/client_history_mode.dart';
import 'package:home_arrest/utils/utils.dart';

class ClientHistoryCell extends StatelessWidget {
  final ClientHistoryModel clientHistoryModel;
  const ClientHistoryCell({super.key, required this.clientHistoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientHistoryModel.dateTime,
                            style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[700]),
                          ),
                          Text(
                            clientHistoryModel.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Image.asset('assets/images/rectangle.png'),
          ),
        ],
      ),
    );
  }
}
