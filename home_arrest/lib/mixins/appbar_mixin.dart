import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AppbarMixin {
  Widget leading({double size = 80, double radius = 10, Color? color, VoidCallback? onPressed}) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          iconSize: 22,
          color: color,
          onPressed: onPressed ?? () => Navigator.pop(context),
        );
      },
    );
  }

  AppBar baseStyleAppBar({
    required String title,
    Widget? leadingWidget,
    bool automaticallyImplyLeading = true,
    List<Widget>? actions,
    Color? backgroundColor = const Color(0xFF0D0E2C),
    Color? titleColor = Colors.white,
  }) {
    Widget leadingView = leadingWidget ?? leading();
    return AppBar(
      backgroundColor: backgroundColor,
      leading: automaticallyImplyLeading ? leadingView : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: titleColor),
      ),
      actions: actions,
      leadingWidth: 68,
    );
  }

  SliverAppBar baseSliverAppBar({
    required String title,
    Widget? leadingWidget,
    bool automaticallyImplyLeading = true,
    List<Widget>? actions,
    Color? backgroundColor,
    bool pinned = false,
    bool floating = false,
  }) {
    Widget leadingView = leadingWidget ?? leading();
    return SliverAppBar(
      leading: automaticallyImplyLeading ? leadingView : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title),
      actions: actions,
      leadingWidth: 68,
      backgroundColor: backgroundColor,
      pinned: pinned,
      floating: floating,
    );
  }
}
