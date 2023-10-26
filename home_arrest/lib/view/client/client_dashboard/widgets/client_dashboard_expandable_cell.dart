import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';

import '../../../../data/model/client.dart';
import '../../../../utils/utils.dart';
import '../../client_location/client_location.dart';

class ClientDashboardExpandableCell extends StatefulWidget {
  final ClientModel clientModel;
  const ClientDashboardExpandableCell({super.key, required this.clientModel});

  @override
  State<ClientDashboardExpandableCell> createState() => _ClientDashboardExpandableCellState();
}

class _ClientDashboardExpandableCellState extends State<ClientDashboardExpandableCell> {
  bool isExpanded = false;

  void setIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (isExpanded && widget.clientModel.associatedUsers.isNotEmpty) ? 80 : 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setIsExpanded();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.clientModel.name, style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                  Icon(!isExpanded ? Icons.arrow_forward_ios : Icons.expand_more, color: const Color(0xFF21356A), size: isExpanded ? 25 : 15)
                ],
              ),
            ),
          ),
          Column(
            children: List.generate(
              widget.clientModel.associatedUsers.length,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ClientLocationScreen.routeName);
                  },
                  child: SizedBox(
                    height: isExpanded ? 40 : 0,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImagesConstants.client, height: 15, width: 15),
                        const SizedBox(width: 10),
                        Text(
                          widget.clientModel.associatedUsers[index],
                          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
