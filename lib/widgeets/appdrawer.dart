import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/services/getuserdata.dart';

class NavigationDrawers extends StatefulWidget {
  const NavigationDrawers({super.key});

  @override
  State<NavigationDrawers> createState() => _NavigationDrawersState();
}

class _NavigationDrawersState extends State<NavigationDrawers> {
  Map<String, dynamic> userData = {};
  final UserDataService _userDataService = UserDataService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String noteColor = "";

  String getRandomColor() {
    final List<String> colorKeys = NoteColors.keys.toList();
    final Random random = Random();
    final String randomColor = colorKeys[random.nextInt(colorKeys.length)];
    return randomColor;
  }

  @override
  void initState() {
    super.initState();
    noteColor = getRandomColor();
    print(noteColor);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await _userDataService.getUserData();
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: Color(NoteColors[this.noteColor]!['l']!.toInt()),
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => UserProfileScreen()),
            // );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Color(NoteColors[this.noteColor]!['b']!.toInt()),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 70,
                      child: Text(
                        "${userData["name"]}".substring(0, 1).toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 80, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "${userData["name"]}".toUpperCase(),
                    style:
                        GoogleFonts.poppins(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 15,
        children: [
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text(
              "Dashboard",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   new MaterialPageRoute(
              //     builder: (context) => HomeScreen(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text(
              "Contact Us",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (c) => const ContactUs()),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text(
              "About Us",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (c) => const AboutUs()),
              // );
            },
          ),
          Divider(
            color: Colors.grey,
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Sign Out",
              style: GoogleFonts.poppins(fontSize: 17),
            ),
            onTap: () async {
              //await CacheHelper.removeData(key: AppConstants.userKey);
            },
          )
        ],
      );
}
