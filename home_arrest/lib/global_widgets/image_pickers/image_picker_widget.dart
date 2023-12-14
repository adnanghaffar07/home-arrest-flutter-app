import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'custom_image.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? rawFile;
  final String image;
  final Function onTap;
  const ImagePickerWidget({super.key, required this.rawFile, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      ClipOval(child: rawFile != null ? Image.memory(rawFile!, width: 70, height: 70, fit: BoxFit.fill) : CustomImage(image: image, height: 70, width: 70, fit: BoxFit.fill)),
      Positioned(
        bottom: 0,
        right: 0,
        top: 0,
        left: 0,
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Container(
              margin: const EdgeInsets.all(25),
              child: const Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ),
      ),
    ]));
  }
}
