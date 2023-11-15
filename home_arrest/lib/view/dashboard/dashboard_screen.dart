import 'package:flutter/material.dart';
import 'package:home_arrest/providers/dashboard_provider.dart';
import 'package:home_arrest/view/alert/alerts_listing_screen.dart';
import 'package:home_arrest/view/client/client_dashboard/client_dashboard.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  DashboardScreen({super.key});

  final List<Widget> screens = [
    const ClientDashboardScreen(),
    Container(color: Colors.white),
    Container(color: Colors.white),
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
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0D0E2C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
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
                          style: TextStyle(
                            color: provider.bottomItems[index].isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )),
        );
      },
    );
  }
}
