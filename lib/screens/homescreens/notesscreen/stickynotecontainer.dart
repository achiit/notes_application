import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notesapp/screens/homescreens/notesscreen/stickynote.dart';

class RectangleStickyNote extends StatelessWidget {
  final Widget? child;
  final Color color;

  RectangleStickyNote({this.child, this.color = const Color(0xffffff00)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height as needed
      child: Transform.rotate(
        angle: 0.01 * pi,
        child: CustomPaint(
          painter: StickyNotePainter(color: color),
          child: Center(child: child),
        ),
      ),
    );
  }
}
