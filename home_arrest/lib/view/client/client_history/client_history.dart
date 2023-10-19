import 'package:flutter/material.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';
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
                                  'History',
                                  style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                                ),
                                const Icon(Icons.map_outlined, color: Color(0xFF21356A), size: 20),
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
                            itemCount: provider.clientHisotry.length,
                            itemBuilder: (context, index) {
                              return ClientHistoryCell(clientHistoryModel: provider.clientHisotry[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 50,
                              );
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
