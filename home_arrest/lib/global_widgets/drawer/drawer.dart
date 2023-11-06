import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';
import 'package:home_arrest/view/client/client_details/client_details.dart';

import '../../utils/utils.dart';
import '../../view/profile/profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF21356A),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/adnan.png', height: 56, width: 56),
                  const SizedBox(width: 10),
                  Text(
                    "Adnan Ghaffar",
                    style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Text(
                    "adnan@codeautomation.ai",
                    style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  _drawerItems.length,
                  (index) {
                    var _model = _drawerItems[index];
                    return Container(
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF2F2F2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.pushNamed(context, ProfileScreen.routeName);
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(_model.icon, height: 20, color: const Color(0xFF21356A)),
                                  const SizedBox(width: 20),
                                  Text(_model.title, style: Utils.safeGoogleFont('Poppins', fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios, color: Color(0xFF21356A), size: 15)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _DrawerModel {
  final String title;
  final String icon;

  _DrawerModel({required this.title, required this.icon});
}

List<_DrawerModel> _drawerItems = [
  _DrawerModel(
    title: 'My Profile',
    icon: ImagesConstants.userProfile,
  ),
  _DrawerModel(
    title: 'About Us',
    icon: ImagesConstants.info,
  ),
  _DrawerModel(
    title: 'Contact Us',
    icon: ImagesConstants.calendar,
  ),
  _DrawerModel(
    title: 'Logout',
    icon: ImagesConstants.logout,
  ),
];
