import 'package:flutter/material.dart';
import '../../constants/image_constants.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            ImagesConstants.logo,
            width: height * 0.17,
            height: height * 0.17,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: height * 0.03),
          Text(
            'no_result_found',
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: height * 0.02),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
