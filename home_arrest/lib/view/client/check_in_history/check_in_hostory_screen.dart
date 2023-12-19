// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../../global_widgets/drawer/drawer.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import 'check_in_history_cell.dart';

class CheckInHistoryScreen extends StatefulWidget {
  static const String routeName = '/CheckInHistoryScreen';

  final bool isFromNav;
  const CheckInHistoryScreen({super.key, this.isFromNav = true});

  @override
  State<CheckInHistoryScreen> createState() => _BraceletHistoryScreenState();
}

class _BraceletHistoryScreenState extends State<CheckInHistoryScreen> with AppbarMixin {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        drawer: widget.isFromNav ? const HomeDrawer() : null,
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Check-ins',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF21356A),
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black, width: 0.7)),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return const CheckInHistoryCell();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 0.6, width: double.infinity, color: Colors.black);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
