import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlippingCard extends StatefulWidget {
  final Widget frontSide;
  final Widget backSide;

  const FlippingCard({
    required this.frontSide,
    required this.backSide,
  });

  @override
  _FlippingCardState createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation; // Use Animation<double> here
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  bool _isFrontSide = true;
  int _flipsRemaining = 4; // Number of flips remaining

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    // Start automatic flipping after a delay of 2 seconds
    _startAutomaticFlipping();
  }

  void _startAutomaticFlipping() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_flipsRemaining > 0) {
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        _flipsRemaining--;
      } else {
        timer.cancel(); // Stop the timer after 3 flips
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(pi * _animation.value),
      child: GestureDetector(
        onTap: () {
          if (_animationStatus == AnimationStatus.dismissed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: _animation.value <= 0.5 ? widget.frontSide : widget.backSide,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
