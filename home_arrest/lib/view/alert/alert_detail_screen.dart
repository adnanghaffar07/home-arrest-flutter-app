import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/utils/utils.dart';

import '../../mixins/appbar_mixin.dart';

class AlertDetailScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/alert-detail-screen';
  const AlertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Alerts',
          backgroundColor: Colors.transparent,
          titleColor: const Color.fromARGB(255, 8, 8, 10),
          leadingWidget: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Color(0xFF21356A)),
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
        body: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Image.asset('assets/images/adnan.png', height: 50),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Adnan Ghaffar', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                    Text(
                      'Alert Date: 08 Nov 2023 Time: 20:37:01',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
