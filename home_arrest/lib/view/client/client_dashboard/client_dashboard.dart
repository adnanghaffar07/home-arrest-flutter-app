import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:home_arrest/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/drawer/drawer.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../global_widgets/image_pickers/custom_image.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';
import 'widgets/client_dashboard_detail_widget.dart';

class ClientDashboardScreen extends StatefulWidget {
  static const String routeName = '/client-dashboard';
  const ClientDashboardScreen({super.key});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> with AppbarMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserProvider>(context, listen: false).getUserDetails(context);
      await Provider.of<ClientProvider>(context, listen: false).getOffendorsListing(context).then((value) {
        if (Provider.of<ClientProvider>(context, listen: false).offenders.isNotEmpty) {
          Provider.of<ClientProvider>(context, listen: false).setSelectedOffendor(1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        drawer: const HomeDrawer(),
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Dashboard',
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
              onTap: () {
                // Navigator.of(context).pushNamed(SearchClientScreen.routeName);
              },
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
        body: Consumer<ClientProvider>(
          builder: (context, clientProvider, child) {
            return clientProvider.isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : clientProvider.offenders.isNotEmpty
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          final screenWidth = MediaQuery.of(context).size.width;
                          final totalWidth = clientProvider.offenders.length * 65;
                          log('totalWidth $totalWidth, screenWidth $screenWidth, showArrow ${totalWidth > screenWidth}');
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      controller: _scrollController,
                                      itemCount: clientProvider.offenders.length,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                      itemBuilder: (context, index) {
                                        var offender = clientProvider.offenders[index];

                                        return InkWell(
                                          onTap: () {
                                            clientProvider.setSelectedOffendor(index);
                                          },
                                          child: Container(
                                            width: 65,
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 55,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 3,
                                                      color: offender.monitorLevel == 3
                                                          ? Colors.green
                                                          : offender.monitorLevel == 2
                                                              ? Colors.yellow
                                                              : Colors.red,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: CustomImage(image: offender.profilePic ?? '', height: 55, width: 55, fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 3.5),
                                                Text(
                                                  '${offender.firstName}',
                                                  style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w500),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(width: 0);
                                      },
                                    ),
                                  ),
                                  if (totalWidth > screenWidth)
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          _scrollController.animateTo(
                                            _scrollController.position.maxScrollExtent,
                                            duration: const Duration(milliseconds: 700),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 2), color: const Color(0xFF21356A).withOpacity(0.9)),
                                              child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
                                            ),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Expanded(child: CLientDashboardDetailWidget(offendorModel: clientProvider.offenders.where((element) => element.isSelected).toList()[0])),
                            ],
                          );
                        },
                      )
                    : Center(child: Text('No Clients Found', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF21356A))));
          },
        ),
      ),
    );
  }
}
