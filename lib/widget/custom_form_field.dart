import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool suffix;
  final TextInputAction? textInputAction;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.suffix = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: labelText,
      ),
    );
  }
}
