import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final String? Function(String?) validator;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    required this.validator,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          vertical: size.width > 600 ? size.width * 0.020 : size.width * 0.042,
          horizontal: size.width * 0.04,
        ),
        prefixIcon: prefixIcon,
      ),
      validator: validator,
      style: style,
    );
  }
}
