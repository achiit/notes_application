import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/auth/login.dart';
import 'package:notesapp/screens/homescreens/aboutscreen.dart';
import 'package:notesapp/services/getuserdata.dart';
import 'package:notesapp/widgeets/customalertdialog.dart';
import 'package:notesapp/widgeets/custombutton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  final UserDataService _userDataService = UserDataService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await _userDataService.getUserData();
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Me",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 52,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData["name"] ?? "",
                            softWrap: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Text(
                            userData["email"] ?? "",
                            softWrap: true,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  label: Text(
                    "About",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomAlert(
                          title: "Log Out",
                          title1: "Are you sure you want to log out?",
                          title2: "Log Out",
                          onpressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false);
                          },
                        ));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 60),
                  backgroundColor: Color(0xffFFB347),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "LOG OUT",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ))
        ],
      )),
    );
  }
}
