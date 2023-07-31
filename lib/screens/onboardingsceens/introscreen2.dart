import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/auth/login.dart';
import 'package:notesapp/widgeets/custombutton.dart';

class IntroScreen2 extends StatefulWidget {
  const IntroScreen2({super.key});

  @override
  State<IntroScreen2> createState() => _IntroScreen2State();
}

class _IntroScreen2State extends State<IntroScreen2> {
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
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "",
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset("assets/images/introscreen2.png"),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "To-dos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "List out your day-to-day tasks",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 90,
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
