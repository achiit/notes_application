import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/auth/login.dart';
import 'package:notesapp/widgeets/custombutton.dart';

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE0E0E0),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME TO\nNOTE IT",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset("assets/images/introscreen1.png"),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Take Notes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Quickly capture what’s on your mind",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              CustomButton(
                onpressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                      (route) => false);
                },
                buttoncolor: Color(0xffFFB347),
                textcolor: Colors.white,
                title: "CREATE ACCOUNT",
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onpressed: () {
                   Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                buttoncolor: Colors.white,
                textcolor: Color(0xffFFB347),
                title: "LOGIN",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
