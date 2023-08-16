import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/auth/forgotpassword.dart';
import 'package:notesapp/screens/homescreens/helpwidget.dart';
import 'package:notesapp/widgeets/customnavbar.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Color(0xffFFB347),
            width: double.infinity,
            height: 250,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Help",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "User Guide",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 50,
          ),
          HelpScreenButton(
            ontap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CustomNavBar()),
                  (route) => false);
            },
            title: "Notes",
            icon: Icons.sticky_note_2_outlined,
          ),
          SizedBox(
            height: 50,
          ),
          HelpScreenButton(
            ontap: () {},
            title: "Reset Password",
            icon: Icons.lock_outline,
          )
        ],
      )),
    );
  }
}
