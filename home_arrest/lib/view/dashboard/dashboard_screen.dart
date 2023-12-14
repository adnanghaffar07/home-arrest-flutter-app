import 'package:flutter/material.dart';
import 'package:home_arrest/providers/dashboard_provider.dart';
import 'package:home_arrest/view/alert/alerts_listing_screen.dart';
import 'package:home_arrest/view/client/add_offender/add_offender_screen.dart';
import 'package:home_arrest/view/client/client_dashboard/client_dashboard.dart';
import 'package:provider/provider.dart';

import '../house_arrest_clients/house_arrest_clients_listing.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  DashboardScreen({super.key});

  final List<Widget> screens = [
    const ClientDashboardScreen(),
    const HouseArrestClientsListing(),
    const AddOffenderScreen(),
    const AlertsListingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          extendBody: true,
          body: screens[provider.selectedIndex],
          bottomNavigationBar: Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF21356A),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(provider.bottomItems.length, (index) {
                return InkWell(
                  onTap: () {
                    provider.changeIndex(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        provider.bottomItems[index].icon,
                        height: 25,
                        color: provider.bottomItems[index].isSelected ? Colors.white : Colors.grey[600],
                      ),
                      Text(
                        provider.bottomItems[index].title,
                        style: TextStyle(color: provider.bottomItems[index].isSelected ? Colors.white : Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
