import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String labeltext;
  String hinttext;
  IconData? icon;
  Widget? suffixicon;
  bool obscure;
  TextEditingController? controller;
  String? Function(String?)? validate;
  void Function(String)? onchange;
  CustomTextFormField({
    super.key,
    required this.labeltext,
    required this.hinttext,
    this.icon,
    this.controller,
    this.suffixicon,
    required this.obscure,
    this.onchange,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchange,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.red,
        suffixIcon: suffixicon,
        hintText: hinttext,
        labelText: labeltext,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Icon(
            icon,
            size: 35,
            color: Color(0xffFFB347),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      validator: validate,
      obscureText: obscure,
    );
  }
}
