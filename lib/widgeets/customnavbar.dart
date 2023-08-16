import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:notesapp/screens/homescreens/helpscreen.dart';
import 'package:notesapp/screens/homescreens/notesscreen/homescreen.dart';
import 'package:notesapp/screens/homescreens/ocr/ocrcamera.dart';
import 'package:notesapp/screens/homescreens/ocr/ocrscreen.dart';
import 'package:notesapp/screens/homescreens/profilescreen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  
  final tabs = [
    const Center(
      child: NotesScreen(),
    ),
    const Center(
      child: OcrCamera(),
    ),
    const Center(
      child: HelpScreen(),
    ),
    Center(
      child: ProfileScreen(),
    ),
  ];
  var navigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    //final navigationBarIndex = Provider.of<NavigationViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[navigationBarIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: Color(0xffF1F1F1),
          onTap: (index) {
            changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
          currentIndex: navigationBarIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                navigationBarIndex == 0
                    ? Icons.note_alt_sharp
                    : Icons.note_alt_outlined,
                color: navigationBarIndex == 0 ? Colors.orange : Colors.black,
              ),
              label: "Notes",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                navigationBarIndex == 1
                    ? "assets/icons/FigmaAsset 08-08-2023 xT2T.svg"
                    : "assets/icons/FigmaAsset 08-08-2023 xT2T.svg",
                color: navigationBarIndex == 1 ? Colors.orange : Colors.black,
              ),
              label: "Notes",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                navigationBarIndex == 2 ? Icons.help : Icons.help_outline,
                color: navigationBarIndex == 2 ? Colors.orange : Colors.black,
              ),
              label: "Help",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                navigationBarIndex == 3 ? Icons.person : Icons.person_outline,
                color: navigationBarIndex == 3 ? Colors.orange : Colors.black,
              ),
              label: "Me",
            ),
          ],
        ),
      ),
    );
  }

  changeIndex(int index) {
    navigationBarIndex = index;
    setState(() {});
  }
}
