import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {this.controller,
      this.labelName,
      this.hintText,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.obscuringCharacter = '•',
      Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final String? labelName;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelName,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange)),
          border: const OutlineInputBorder(),
        ),
        validator: validator);
  }
}
