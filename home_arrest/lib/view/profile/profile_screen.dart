import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';
import 'package:home_arrest/view/client/client_profile/client_profile_screen.dart';

import '../../utils/utils.dart';

class ProfileScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'My Profile',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF0D0E2C),
          leadingWidget: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
            );
          }),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFF2F2F2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Adnan Ghaffar', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF21356A), size: 15),
                          onPressed: () {
                            Navigator.pushNamed(context, ClientProfileScreen.routeName);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/adnan.png', height: 50),
                            const SizedBox(width: 20),
                            Text('Adnan Ghaffar', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'PHONE',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '+1 (613) 316-6042',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'EMAIL',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          'adnan@codeautomation.ai',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'HOME ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '30 N Gould St Ste 7596, Sheridan, WY, 82801.',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'WORK ADDRESS',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                        ),
                        Text(
                          '30 N Gould St Ste 7596, Sheridan, WY, 82801.',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
