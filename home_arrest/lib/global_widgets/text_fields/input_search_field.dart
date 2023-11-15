import 'package:flutter/material.dart';

class InputSearchField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;
  final bool enabled;
  final void Function()? onTap;

  const InputSearchField({
    Key? key,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.hintText,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    InputBorder? border = InputBorder.none;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          enabled: enabled,
          textInputAction: textInputAction,
          cursorHeight: 15,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15, left: 20),
            suffixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF0D0E2C)),
            hintText: hintText,
            border: border,
            enabledBorder: border,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
