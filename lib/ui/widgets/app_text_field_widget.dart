import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLines;

  const AppTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText, this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,

        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
