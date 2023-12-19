import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class ClientLocationExpandableCell extends StatefulWidget {
  final String title;
  final Widget data;
  final double expandedHeight;
  const ClientLocationExpandableCell({super.key, required this.title, required this.data, this.expandedHeight = 80});

  @override
  State<ClientLocationExpandableCell> createState() => _ClientLocationExpandableCellState();
}

class _ClientLocationExpandableCellState extends State<ClientLocationExpandableCell> {
  bool isExpanded = false;

  void setIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: isExpanded ? widget.expandedHeight : 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF2F2F2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setIsExpanded();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title,  style: Utils.safeGoogleFont('Poppins', fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFF21356A)),),
                  Icon(!isExpanded ? Icons.arrow_forward_ios : Icons.expand_more, color: const Color(0xFF21356A), size: isExpanded ? 25 : 15)
                ],
              ),
            ),
          ),
          if (isExpanded) Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
          if (isExpanded) const SizedBox(height: 15),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: widget.data,
            )
        ],
      ),
    );
  }
}
