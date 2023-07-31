import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  VoidCallback onpressed;
  Color textcolor;
  Color buttoncolor;
  CustomButton(
      {super.key,
      required this.onpressed,
      required this.buttoncolor,
      required this.textcolor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(
          title,
          style: TextStyle(color: textcolor),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: buttoncolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            fixedSize: Size(343, 50)),
      ),
    );
  }
}
