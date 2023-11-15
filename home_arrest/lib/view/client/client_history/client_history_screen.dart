import 'package:flutter/material.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';
import '../client_locations/client_locations_screen.dart';
import 'history_detail_screen.dart';
import 'widgets/client_history_cell.dart';

class ClientHistoryScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/client-history';
  const ClientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
            title: 'Client History',
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
                onPressed: () {
                  Navigator.pushNamed(context, ClientLocationsScreen.routeName);
                },
              ),
              const SizedBox(width: 10),
            ]),
        body: Consumer<ClientProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.clientHisotry.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, HistoryDetailScreen.routeName);
                            },
                            child: ClientHistoryCell(clientHistoryModel: provider.clientHisotry[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
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
