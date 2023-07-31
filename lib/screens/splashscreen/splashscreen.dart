import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/screens/homescreens/notesscreen/homescreen.dart';
import 'package:notesapp/screens/onboardingsceens/onboardingview.dart';
import 'package:notesapp/widgeets/customnavbar.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget checkLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return CustomNavBar();
    } else {
      return OnboardingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/3d-render-smartphone-with-hand-fill-online-survey 1.png',
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'NOTE IT',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        splashIconSize: 300,
        nextScreen: checkLogin(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop);
  }
}
