// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../../../global_widgets/drawer/drawer.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';
import 'eCellHabit_cell.dart';

class ECellHabitHistoryScreen extends StatefulWidget {
  static const String routeName = '/ECellHabitHistoryScreen';

  final bool isFromNav;
  const ECellHabitHistoryScreen({super.key, this.isFromNav = true});

  @override
  State<ECellHabitHistoryScreen> createState() => _ECellHabitHistoryScreenState();
}

class _ECellHabitHistoryScreenState extends State<ECellHabitHistoryScreen> with AppbarMixin {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        drawer: widget.isFromNav ? const HomeDrawer() : null,
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'E-Cell HABIT History',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF21356A),
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
          ),
        ),
        body: const ECellHabitCell(),
      ),
    );
  }
}
