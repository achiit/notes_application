import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/screens/homescreens/notesscreen/homescreen.dart';
import 'package:notesapp/screens/onboardingsceens/onboardingview.dart';
import 'package:notesapp/screens/splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange, /* fontFamily: "Gerbil" */
      ),
      home: const SplashScreen(),
    );
  }
}
