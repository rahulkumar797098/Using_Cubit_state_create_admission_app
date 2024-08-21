import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final VoidCallback? suffixOnTop;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.suffixOnTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.lightBlueAccent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: suffixOnTop,
          icon: suffixIcon!,
        )
            : null, // Set to null if no suffixIcon is provided
      ),
    );
  }
}
