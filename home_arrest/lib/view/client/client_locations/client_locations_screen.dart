import 'package:flutter/material.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';

class ClientLocationsScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/client-locations';
  const ClientLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
            title: 'Clients',
            backgroundColor: Colors.transparent,
            titleColor: const Color(0xFF0D0E2C),
            leadingWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.map_outlined, color: Color(0xFF21356A), size: 20),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            'assets/images/client_locations.png',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
          ),
        ),
      ),
    );
  }
}
