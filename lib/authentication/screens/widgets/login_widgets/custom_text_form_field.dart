import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  const CTextFormField({
    super.key,
    required this.controller,  this.obscureText = false, required this.labelText, required this.prefixIcon,  this.suffixIcon,  this.keyboardType,
  });
final bool? obscureText ;
final String labelText;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        obscureText: obscureText!,
        keyboardType: keyboardType,
      decoration:  InputDecoration(
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Color(0xFFFFC300)),
        ),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Color(0xFFFFC300)),
        ),
        focusedBorder:const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Color(0xFFFFC300)),
        ),
        errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Color(0xFFF57C00)),
        ),
        focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2, color: Color(0xFFF57C00)),
        ),
        prefixIcon: prefixIcon,prefixIconColor: const Color(0xFF73731F),
        suffixIcon: suffixIcon,suffixIconColor: const Color(0xFF73731F),

        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFFFC300),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF757575),
        ),
        fillColor: const Color(0xFFFBFBFB),
        filled: true,
      ),
      style: const TextStyle(
        color: Color(0xFF000000),
      ),
    );
  }
}