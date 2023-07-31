import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:notesapp/constants/colors.dart';

class ColorPalette extends StatelessWidget {
  final parentContext;
  const ColorPalette({@required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Wrap(
            alignment: WrapAlignment.start,
            spacing: MediaQuery.of(context).size.width * 0.02,
            runSpacing: MediaQuery.of(context).size.width * 0.02,
            children: NoteColors.entries.map((e) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(e.key),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.06),
                    color: Color(e.value['b']!.toInt()),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
