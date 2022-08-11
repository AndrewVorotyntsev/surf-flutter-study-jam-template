import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key? key,
    this.controller,
    this.maxLength,
    this.hintText,
    this.helperText,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.onChange,
  }) : super(key: key);

  final TextEditingController? controller;
  final int? maxLength;
  final Function(String)? onChange;
  final String? hintText;
  final String? helperText;
  final Widget? suffixIcon;
  final void Function()? onSuffixIconTap;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        helperText: helperText,
        hintText: hintText,
        suffixIcon: suffixIcon == null
            ? null
            : InkResponse(
          onTap: onSuffixIconTap,
          child: suffixIcon,
          radius: 20.0,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onChanged: onChange,
    );
  }
}