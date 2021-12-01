import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputAction? textInputAction;
  final double marginTop;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.textInputAction,
    this.marginTop = 0,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.marginTop),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        textInputAction: widget.textInputAction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: const Icon(Icons.remove_red_eye),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
