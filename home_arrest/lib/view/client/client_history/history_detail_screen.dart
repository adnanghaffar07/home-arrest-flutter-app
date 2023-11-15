import 'package:flutter/material.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';
import '../client_info/client_info_screen.dart';

class HistoryDetailScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/history-detail';
  const HistoryDetailScreen({super.key});

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
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  ClientInfoScreen()));
                          },
                          child: Padding(
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
                        ),
                        const SizedBox(height: 15),
                        Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.greenAccent[100],
                                    ),
                                    child: Center(
                                      child: Icon(Icons.schedule, color: Colors.green[900], size: 18),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    '24 Mar, 11:34 PM',
                                    style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[700])
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '30 N Gould St Ste 7596, Sheridan, WY, 82801.',
                                style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                              const SizedBox(height: 20),
                              Image.asset('assets/images/map_new.png'),
                            ],
                          ),
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
