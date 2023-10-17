import 'package:flutter/material.dart';

import '../../constants/image_constants.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const HeaderWidget({super.key, this.title = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(ImagesConstants.arrowBack, height: 50, width: 50),
          Text(title, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}
