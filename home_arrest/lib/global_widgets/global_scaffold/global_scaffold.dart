import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const GlobalScaffold({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(ImagesConstants.background, width: MediaQuery.of(context).size.width * 0.8),
          ),
          child,
        ],
      ),
    );
  }
}
