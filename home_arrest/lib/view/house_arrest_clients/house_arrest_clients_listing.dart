import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';

import '../../constants/image_constants.dart';
import '../../global_widgets/drawer/drawer.dart';
import '../../utils/utils.dart';
import '../client/client_history/client_history_screen.dart';

class HouseArrestClientsListing extends StatelessWidget with AppbarMixin {
  const HouseArrestClientsListing({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        drawer: const HomeDrawer(),
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Clients',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF0D0E2C),
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
              child: Container(
                height: 45,
                width: 45,
                padding: const EdgeInsets.all(13),
                child: Center(child: Image.asset(ImagesConstants.filter)),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            'Clients',
                            style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
                    const SizedBox(height: 15),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                    const SizedBox(height: 15),
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
