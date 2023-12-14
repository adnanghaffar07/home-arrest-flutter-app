import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget title;
  final void Function()? onTap;
  final Color? unPressColor;
  final Color? pressColor;
  final double borderRadius;
  final Widget? icon;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    this.onTap,
    required this.title,
    this.unPressColor = const Color(0xFF21356A),
    this.pressColor = const Color(0xFF384569),
    this.borderRadius = 10.0,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return pressColor!;
              }
              return unPressColor!;
            },
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: icon == null ? 0 : 40),
                  title,
                  if (icon == null) const SizedBox(),
                  if (icon != null) icon!,
                ],
              )
            : const Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))),
      ),
    );
  }
}
