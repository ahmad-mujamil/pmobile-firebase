import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isObscure;
  final TextEditingController controller;
  final VoidCallback? showPassword;

  // Constructor with dynamic variables
  CustomTextInput({
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    required this.controller,
    this.showPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        
        // Dynamic icon
        prefixIcon: Icon(icon, color: Colors.blueAccent),

        suffixIcon: ((showPassword != null) ? IconButton(
          icon: Icon((isObscure) ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
          onPressed:showPassword
        ) : null),

        // Border and fill styles
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      
      style: TextStyle(color: Colors.black87, fontSize: 16),
      cursorColor: Colors.blueAccent,
      textInputAction: TextInputAction.done,
    );
  } 
  
}