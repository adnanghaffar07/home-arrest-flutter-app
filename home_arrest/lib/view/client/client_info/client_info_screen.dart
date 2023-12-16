import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_arrest/constants/image_constants.dart';
import 'package:home_arrest/extensions/margin_or_padding_extension.dart';
import 'package:home_arrest/global_widgets/image_pickers/custom_image.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:home_arrest/view/client/client_info/sub_screens/client_contact_screen.dart';
import 'package:home_arrest/view/client/client_info/sub_screens/client_offense_screen.dart';
import 'package:home_arrest/view/client/client_info/sub_screens/client_work_screen.dart';
import 'package:home_arrest/view/client/client_info/widgets/basic_info_widget.dart';
import 'package:home_arrest/view/client/ping_current_location/ping_current_location_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/model/offender_model.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import '../../../utils/utils.dart';
import '../request_check_in/request_check_in_screen.dart';

class ClientInfoScreen extends StatefulWidget {
  final OffendorModel? offendorModel;
  const ClientInfoScreen({super.key, this.offendorModel});

  @override
  State<ClientInfoScreen> createState() => _ClientInfoScreenState();
}

class _ClientInfoScreenState extends State<ClientInfoScreen> with AppbarMixin {
  List<String> tabs = [ImagesConstants.call, ImagesConstants.clipboard, ImagesConstants.document, ImagesConstants.locate, ImagesConstants.pointer];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ClientProvider>(context, listen: false).setSelectedClientInfoType(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(child: Consumer<ClientProvider>(
      builder: (context, clientProvider, child) {
        return Scaffold(
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
                      PopupMenuItem(value: '/Court-Order', child: Text("Court Order")),
                      PopupMenuItem(value: '/Monioring-Service', child: Text("Monioring Service")),
                      PopupMenuItem(value: '/Offender-Info', child: Text("Offender Info Order")),
                      PopupMenuItem(value: '/Promissory-Note', child: Text("Promissory Note")),
                      PopupMenuItem(value: '/Guaranty-Agreement', child: Text("Guaranty Agreement")),
                      PopupMenuItem(value: '/Commencement', child: Text("Commencement")),
                      PopupMenuItem(value: '/Completion', child: Text("Completion"))
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
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(context, PingCurrentLocationScreen.routeName);
                        } else if (index == 1) {
                          Navigator.pushNamed(context, RequestCheckInScreen.routeName);
                        }
                      },
                      child: Container(
                        width: 63,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(color: const Color(0xFF21356A), borderRadius: BorderRadius.circular(7)),
                        padding: const EdgeInsets.symmetric(vertical: 07),
                        child: Image.asset(tabs[index], color: Colors.white),
                      ),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CustomImage(image: widget.offendorModel?.profilePic, height: 50, width: 50),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${widget.offendorModel?.firstName} ${widget.offendorModel?.lastName} (${widget.offendorModel?.active})',
                                  style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF21356A))),
                              Text("Sentence: ${DateFormat('dd MMM y').format(DateTime.parse(widget.offendorModel!.sentenceStartDate!))} till ${DateFormat('dd MMM y').format(DateTime.parse(widget.offendorModel!.sentenceEndDate!))}",
                                      style: Utils.safeGoogleFont('Poppins', fontSize: 12, fontWeight: FontWeight.w300, color: const Color(0xFF21356A)))
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
                            'Pin No: ${widget.offendorModel?.pinNumber ?? 'N/A'}',
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
              if (clientProvider.selectedClientInfoType == null)
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 13, mainAxisSpacing: 5),
                  shrinkWrap: true,
                  itemCount: clientProvider.clientInfoTypes.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(7),
                      onTap: () {
                        if (index == 0) {
                          clientProvider.selectClientInfoType(index);
                        } else if (index == 1) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientOffenseDetailsScreen()));
                        } else if (index == 2) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientContactDetailScreen()));
                        } else if(index == 5){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientWorkDetailScreen()));
                        }
                      },
                      child: Container(
                        width: 50,
                        padding: const EdgeInsets.only(left: 13),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(color: const Color(0xFF21356A).withOpacity(0.07), borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          clientProvider.clientInfoTypes[index].name,
                          style: Utils.safeGoogleFont('Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                        ),
                      ),
                    );
                  }),
                ),
              if (clientProvider.selectedClientInfoType == 'Basic')
                BasicInfoWidget(
                  onTap: () {
                    clientProvider.selectClientInfoType(0);
                  },
                ),
            ],
          ).marginSymmetric(horizontal: 15),
        );
      },
    ));
  }
}
