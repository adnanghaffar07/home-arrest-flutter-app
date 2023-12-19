import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';

import '../../../utils/utils.dart';

class ECellHabitCell extends StatelessWidget {
  const ECellHabitCell({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black, width: 0.7)),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {},
                  visualDensity: VisualDensity.compact,
                  title: Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status:', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                              const SizedBox(height: 5),
                              Text('Unpaired at:', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Unpaired', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
                              const SizedBox(height: 5),
                              Text('01/15/2023  01:05:26', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
                            ],
                          ),
                        ),
                        Image.asset(ImagesConstants.braceletConnection, height: 30,color: Colors.red),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 0.6, width: double.infinity, color: Colors.black);
              },
            ),
          ),
        ],
      ),
    );
  }
}
