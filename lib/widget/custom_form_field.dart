import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool suffix;
  final TextInputAction? textInputAction;
  final double marginTop;

  const CustomFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.prefixIcon,
      this.suffix = false,
      this.textInputAction,
      this.marginTop = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: TextFormField(
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
          labelStyle:
              Theme.of(context).textTheme.subtitle2?.copyWith(color: onSurface),
        ),
        style:
            Theme.of(context).textTheme.subtitle2?.copyWith(color: onSurface),
      ),
    );
  }
}
