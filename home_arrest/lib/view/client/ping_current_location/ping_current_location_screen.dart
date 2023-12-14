import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/utils/utils.dart';

import '../../../mixins/appbar_mixin.dart';

class PingCurrentLocationScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/ping_current_location';
  const PingCurrentLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Client Information',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF21356A),
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ping Current Location',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: const Icon(Icons.map_outlined, color: Color(0xFF21356A), size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
              const SizedBox(height: 15),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/images/map.png', fit: BoxFit.fill),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
