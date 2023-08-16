import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFB347),
        title: Text("About"),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            color: Color(0xffFFB347),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/about1.png",
                  width: 200,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Application"),
                      Text("Note IT"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Version"),
                      Text("1.0.0"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Terms of Use",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Privacy Policy",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
