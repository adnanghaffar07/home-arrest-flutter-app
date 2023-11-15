import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';
import 'package:home_arrest/extensions/margin_or_padding_extension.dart';

import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';

class ClientInfoScreen extends StatefulWidget {
  const ClientInfoScreen({super.key});

  @override
  State<ClientInfoScreen> createState() => _ClientInfoScreenState();
}

class _ClientInfoScreenState extends State<ClientInfoScreen> with AppbarMixin {
  bool _fuiFui = false;

  List<String> tabs = [ImagesConstants.call, ImagesConstants.clipboard, ImagesConstants.document, ImagesConstants.locate, ImagesConstants.pointer];
  List<String> clientinfoOptions = [
    'Basic',
    'Offense',
    'Contact',
    'Bail Bond',
    'Images',
    'Personal Work',
    'Guarantors',
    'Billing History',
    'Friends & Family',
    'Social Media',
    'Liens',
    'Collateral',
    'Co-Signer'
  ];

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
            actions: [
              PopupMenuButton(
                onSelected: (value) {},
                position: PopupMenuPosition.under,
                child: const Icon(
                  Icons.file_copy,
                  color: Color(0xFF21356A),
                ).marginOnly(right: 15),
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      value: '/Court-Order',
                      child: Text("Court Order"),
                    ),
                    PopupMenuItem(
                      value: '/Monioring-Service',
                      child: Text("Monioring Service"),
                    ),
                    PopupMenuItem(
                      value: '/Offender-Info',
                      child: Text("Offender Info Order"),
                    ),
                    PopupMenuItem(
                      value: '/Promissory-Note',
                      child: Text("Promissory Note"),
                    ),
                    PopupMenuItem(
                      value: '/Guaranty-Agreement',
                      child: Text("Guaranty Agreement"),
                    ),
                    PopupMenuItem(
                      value: '/Commencement',
                      child: Text("Commencement"),
                    ),
                    PopupMenuItem(
                      value: '/Completion',
                      child: Text("Completion"),
                    )
                  ];
                },
              ),
            ]),
        body: ListView(
          children: [
            SizedBox(
              height: 55,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 63,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(color: const Color(0xFF21356A), borderRadius: BorderRadius.circular(7)),
                    padding: const EdgeInsets.symmetric(vertical: 07),
                    child: Image.asset(tabs[index], color: Colors.white),
                  );
                }),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFF2F2F2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/adnan.png', height: 50),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Adnan Ghaffar (Active)', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF21356A))),
                            Text("Sentence: 07/15/2023 thur 01/11/2023", style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w300, color: const Color(0xFF21356A)))
                                .marginSymmetric(vertical: 3),
                            Text("Monitor Time: 10:00 thur 22:00", style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w300, color: const Color(0xFF21356A)))
                          ],
                        )),
                        const Icon(Icons.edit_sharp, color: Color(0xFF21356A))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Last Check-in: 10/27/2023 11:12:16',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF21356A)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pin No: 5NUUTT61U2',
                          style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF21356A)),
                        ),
                        const Icon(Icons.qr_code, color: Color(0xFF21356A))
                      ],
                    ),
                    Text(
                      '0 missed check-ins in last 7 days',
                      style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF21356A)),
                    ),
                  ],
                )),
            _fuiFui
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _fuiFui = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFF21356A), width: 0.05)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 13, bottom: 15, top: 15),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(color: const Color(0xFF21356A).withOpacity(0.07)),
                            child: Text(
                              'Basic',
                              style: Utils.safeGoogleFont('Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 13, bottom: 15, top: 15),
                            alignment: Alignment.centerLeft,
                            color: Colors.white,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 13, mainAxisSpacing: 5),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: 50,
                                  padding: const EdgeInsets.only(left: 13),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'AGENT NAME',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF21356A).withOpacity(0.4)),
                                      ),
                                      Text(
                                        'ASHTON',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ))
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 13, mainAxisSpacing: 5),
                    shrinkWrap: true,
                    itemCount: clientinfoOptions.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _fuiFui = true;
                          });
                        },
                        child: Container(
                          width: 50,
                          padding: const EdgeInsets.only(left: 13),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(color: const Color(0xFF21356A).withOpacity(0.07), borderRadius: BorderRadius.circular(7)),
                          child: Text(
                            clientinfoOptions[index],
                            style: Utils.safeGoogleFont('Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                          ),
                        ),
                      );
                    })),
          ],
        ).marginSymmetric(horizontal: 15),
      ),
    );
  }
}
