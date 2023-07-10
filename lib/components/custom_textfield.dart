import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

   final String label;
   final bool isPassword;
   final TextEditingController controller;

  CustomTextField({
    required this.label,
    this.isPassword=false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 22
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration:  InputDecoration(
          border: OutlineInputBorder(),
          label: Text('$label')
        ),
      ),
    );
  }
}
