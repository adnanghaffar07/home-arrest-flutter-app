import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../global_widgets/drawer/drawer.dart';
import '../../providers/client_provider.dart';
import '../../utils/utils.dart';
import '../client/client_info/client_info_screen.dart';

class HouseArrestClientsListing extends StatefulWidget {
  const HouseArrestClientsListing({super.key});

  @override
  State<HouseArrestClientsListing> createState() => _HouseArrestClientsListingState();
}

class _HouseArrestClientsListingState extends State<HouseArrestClientsListing> with AppbarMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ClientProvider>(context, listen: false).getOffendorsListing(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Consumer<ClientProvider>(
        builder: (context, clientProvider, child) {
          return Scaffold(
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
              body: !clientProvider.isLoading
                  ? clientProvider.offenders.isNotEmpty
                      ? SingleChildScrollView(
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
                                          Text(
                                            '(${clientProvider.offenders.length})',
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
                                      itemCount: clientProvider.offenders.length,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ClientInfoScreen(offendorModel: clientProvider.offenders[index])));
                                          },
                                          child: Container(
                                            height: 55,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: const Color(0xFFF2F2F2)),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              children: [
                                                Image.asset(ImagesConstants.client, height: 20, width: 20),
                                                const SizedBox(width: 15),
                                                Text(
                                                  '${clientProvider.offenders[index].firstName} ${clientProvider.offenders[index].lastName}',
                                                  style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),
                                                ),
                                              ],
                                            ),
                                          ),
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
                              const SizedBox(height: 100),
                            ],
                          ),
                        )
                      : Center(child: Text('No Clients Found', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A))))
                  : const Center(child: CupertinoActivityIndicator()));
        },
      ),
    );
  }
}
