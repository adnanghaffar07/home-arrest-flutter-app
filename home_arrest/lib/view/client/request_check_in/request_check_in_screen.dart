import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';

import '../../../utils/utils.dart';

class RequestCheckInScreen extends StatelessWidget with AppbarMixin {
  static const String routeName = '/request_check_in_screen';
  const RequestCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Request Check In',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF21356A),
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  border: Border.all(width: 0.75, color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Please do a Photo Check-in using this Pin number:',
                            style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '02394722',
                            style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(height: 0.75, color: Colors.grey),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: Text(
                              'Select Request Type',
                              style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                            )),
                          ),
                          Container(height: 50, width: 0.75, color: Colors.grey),
                          Expanded(
                            child: Center(
                                child: Text(
                              'Request Type',
                              style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF21356A)),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
