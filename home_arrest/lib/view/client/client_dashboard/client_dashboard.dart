import 'package:flutter/material.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:home_arrest/view/client/client_dashboard/widgets/client_dashboard_expandable_cell.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';

class ClientDashboardScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/client-dashboard';
  const ClientDashboardScreen({super.key});

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
          ),
          body: Consumer<ClientProvider>(
            builder: (context, provider, child) {
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
                                  'Clients',
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
                            itemCount: provider.clients.length,
                            itemBuilder: (context, index) {
                              return ClientDashboardExpandableCell(clientModel: provider.clients[index]);
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
          )),
    );
  }
}
