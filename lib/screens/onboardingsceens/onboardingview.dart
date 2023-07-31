import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/screens/onboardingsceens/introscreen1.dart';
import 'package:notesapp/screens/onboardingsceens/introscreen2.dart';
import 'package:notesapp/screens/onboardingsceens/introscreen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          children: [
            IntroScreen1(),
            IntroScreen2(),
            IntroScreen3(),

            /* Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ) */
          ],
        ),
        Container(
          alignment: Alignment(0, 0.45),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              dotColor: Colors.white,
              activeDotColor: Color(0xffFFB347),
            ),
          ),
        )
      ]),
    );
  }
}
