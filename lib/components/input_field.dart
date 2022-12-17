import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final Widget? labelIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  const InputField(
      {super.key,
      this.hintText,
      this.labelIcon,
      this.controller,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: labelIcon,
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Colors.amber), //<-- SEE HERE
          ),
          border: const OutlineInputBorder(),
          hintText: hintText ?? "",
        ),
      ),
    );
  }
}
