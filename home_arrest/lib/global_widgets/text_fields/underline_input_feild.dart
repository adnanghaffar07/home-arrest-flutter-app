// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_arrest/constants/image_constants.dart';

import '../../utils/utils.dart';

class UnderLineInputTextField extends StatelessWidget {
  final String? label;
  final Widget? trailingLabel;
  final bool isRequired;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final InputDecoration? decoration;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final TextStyle? labelStyle;
  final void Function()? onTap;

  const UnderLineInputTextField({
    Key? key,
    this.label,
    this.trailingLabel,
    this.isRequired = false,
    this.initialValue,
    this.onSaved,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.decoration,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.maxLength,
    this.cursorColor,
    this.textInputAction,
    this.textInputFormatter,
    this.onTap,
    this.labelStyle,
  }) : super(key: key);

  Widget buildInputLine() {
    return TextFormField(
      style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: decoration,
      onSaved: onSaved,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: textInputFormatter,
      cursorColor: cursorColor,
      textInputAction: textInputAction,
    );
  }

  Widget buildInput() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Center(
        child: TextFormField(
          style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: decoration,
          keyboardType: keyboardType,
          inputFormatters: textInputFormatter,
          enabled: enabled,
          maxLength: maxLength,
          cursorColor: cursorColor,
          textInputAction: textInputAction,
          onFieldSubmitted: onSaved,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget input = maxLines != null || minLines != null ? buildInputLine() : buildInput();
    if (label?.isNotEmpty == true || trailingLabel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelInput(title: label ?? '', isRequired: isRequired, trailing: trailingLabel, labelStyle: labelStyle),
          input,
        ],
      );
    }
    return input;
  }
}

class LabelInput extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final bool isLarge;
  final bool isRequired;

  const LabelInput({
    Key? key,
    required this.title,
    this.trailing,
    this.padding,
    this.labelStyle,
    this.isLarge = false,
    this.isRequired = false,
  }) : super(key: key);

  Widget buildContent({
    required String value,
    bool requiredValue = false,
    TextStyle? style,
    required Color colorRequired,
  }) {
    Widget text = RichText(text: TextSpan(text: value, style: style));
    if (trailing != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 16),
          Flexible(child: text),
          trailing ?? Container(),
        ],
      );
    }
    return Row(
      children: [text, Image.asset(ImagesConstants.requiredIcon, width: 20, height: 20, color: requiredValue ? Colors.white : Colors.transparent)],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (isLarge) {
      return Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 10),
        child: buildContent(
          value: title,
          requiredValue: isRequired,
          style: theme.textTheme.titleSmall,
          colorRequired: theme.colorScheme.error,
        ),
      );
    }
    return buildContent(
      value: title,
      requiredValue: isRequired,
      style: labelStyle ?? theme.textTheme.bodySmall,
      colorRequired: theme.colorScheme.error,
    );
  }
}

class LabelView extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLarge;
  final bool isRequired;
  final Widget child;
  const LabelView({
    Key? key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
    this.isLarge = true,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInput(
          title: title,
          trailing: trailing,
          isLarge: isLarge,
          isRequired: isRequired,
          padding: const EdgeInsets.only(bottom: 10),
        ),
        child,
      ],
    );
  }
}
