import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;
  final double elevation;
  final double borderradius;
  final EdgeInsets padding;
  final VoidCallback? onDismissed;

  const CustomSnackbar({
    super.key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.borderradius = 8,
    this.duration = const Duration(seconds: 3),
    this.elevation = 6,
    this.icon = Icons.info,
    this.onDismissed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dismissSnackbar(context);
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
              onPressed: () {
                dismissSnackbar(context);
              },
              icon: Icon(
                Icons.close,
                color: textColor,
              ))
        ],
      ),
    );
  }

  void dismissSnackbar(BuildContext context) {
    if (onDismissed != null) {
      onDismissed!();
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: this,
      duration: duration,
    ));
  }
}
