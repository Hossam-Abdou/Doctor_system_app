import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

   final String label;
   final bool isPassword;
   final TextEditingController controller;
  CustomTextField({
    required this.label,
    this.isPassword=false,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 22
      ),
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.deepPurpleAccent,
            controller: controller,
            obscureText: isPassword,
            style: TextStyle(color: Colors.white),
            decoration:  InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent.shade100)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)) ,
              hintText: '$label',
              hintStyle:  TextStyle(color: Colors.white70,fontSize:15)
            ),
          ),
        ],
      ),
    );
  }
}
