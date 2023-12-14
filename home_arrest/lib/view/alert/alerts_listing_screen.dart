import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/providers/alerts_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../global_widgets/drawer/drawer.dart';
import '../../mixins/appbar_mixin.dart';
import '../../utils/utils.dart';
import 'alert_detail_screen.dart';
import 'widget/alerts_cell.dart';

class AlertsListingScreen extends StatelessWidget with AppbarMixin {
  const AlertsListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        drawer: const HomeDrawer(),
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Alerts',
          backgroundColor: Colors.transparent,
          titleColor: const Color.fromARGB(255, 8, 8, 10),
          leadingWidget: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(13),
                child: Center(child: Image.asset(ImagesConstants.menu)),
              ),
            );
          }),
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(Icons.search, color: Color(0xFF21356A), size: 25),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Consumer<ALertsProvider>(
          builder: (context, alertsProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFF2F2F2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Alerts',
                                style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                              ),
                              Text(
                                '(32)',
                                style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
                        const SizedBox(height: 15),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: alertsProvider.alerts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, AlertDetailScreen.routeName);
                              },
                              child: const AlertsCell(obj: 'data'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
