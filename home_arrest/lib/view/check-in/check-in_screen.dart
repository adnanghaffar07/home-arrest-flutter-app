// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../../constants/image_constants.dart';
import '../../../global_widgets/drawer/drawer.dart';
import '../../../global_widgets/global_scaffold/global_scaffold.dart';
import '../../../mixins/appbar_mixin.dart';

class CheckInScreen extends StatefulWidget {
  static const String routeName = '/CheckInScreen';

  final bool isFromNav;
  const CheckInScreen({super.key, this.isFromNav = true});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> with AppbarMixin {

  @override
  Widget build(BuildContext context) {
    List<String> mainList = ['Cold', 'Poll', 'Beam', 'Greek', 'Song', 'Tight', 'Run', 'Count'];
    return GlobalScaffold(
      child: Scaffold(
        drawer: widget.isFromNav ? const HomeDrawer() : null,
        backgroundColor: const Color(0xFF21356A),
        appBar: baseStyleAppBar(
          title: 'CheckIn',
          backgroundColor: Colors.transparent,
          leadingWidget: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(13),
                child: Center(child: Image.asset(ImagesConstants.menu, color: Colors.white)),
              ),
            );
          }),
          
        ),
        body:  ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){},
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text(mainList[index], textAlign: TextAlign.start,),
                      ),
                    ),
                    Divider(),
                  ],
                )
            );
          })
      ),
    );
  }
}
