import 'package:flutter/material.dart';
import 'package:home_arrest/utils/utils.dart';
import 'package:home_arrest/view/client/client_info/sub_screens/client_basic_screen.dart';

import '../../../../constants/image_constants.dart';
import '../../../dashboard/dashboard_screen.dart';

class BasicInfoWidget extends StatelessWidget {
  final void Function()? onTap;
  const BasicInfoWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF21356A), width: 0.05)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 13, bottom: 15, top: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(color: const Color(0xFF21356A).withOpacity(0.07)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Basic',
                    style: Utils.safeGoogleFont('Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientBasicDetailsScreen()));
                    },
                    child: SizedBox(
                      height: 25,
                      width: 55,
                      child: Center(child: Image.asset(ImagesConstants.edit, height: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 13, bottom: 15, top: 15),
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 13, mainAxisSpacing: 5),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 50,
                    padding: const EdgeInsets.only(left: 13),
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AGENT NAME',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF21356A).withOpacity(0.4)),
                        ),
                        Text(
                          'ASHTON',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
