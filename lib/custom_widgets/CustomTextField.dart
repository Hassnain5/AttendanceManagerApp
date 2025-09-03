import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final String lable;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  // final String keyboardType;
  const CustomTextField({super.key, required this.lable,
    required this.hintText,
    this.isPassword=false,
    required this.controller,
    // required this.keyboardType,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),

        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
