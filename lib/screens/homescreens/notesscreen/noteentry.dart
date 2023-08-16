import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';

class NoteEntry extends StatelessWidget {
  final textFieldController;
  NoteEntry({this.textFieldController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: textFieldController,
        maxLines: null,
        style: GoogleFonts.roboto(fontSize: 20),
        decoration: InputDecoration(
          hintText: "Type Something...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
        ),
      ),
    );
  }
}
