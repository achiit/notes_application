import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/models/notemodel.dart';
import 'package:notesapp/screens/homescreens/notesscreen/noteentry.dart';
import 'package:notesapp/widgeets/colorpalatte.dart';
import 'package:notesapp/widgeets/customnavbar.dart';
import 'package:notesapp/widgeets/customsnackbar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _titlecontroller = TextEditingController();
  final _contentcontroller = TextEditingController();
  String noteColor = "";
  String noteTitle = "";
  String noteContent = "";
  void handleTitleTextChange() {
    setState(() {
      noteTitle = _titlecontroller.text.trim();
    });
  }

  String getRandomColor() {
    final List<String> colorKeys = NoteColors.keys.toList();
    final Random random = Random();
    final String randomColor = colorKeys[random.nextInt(colorKeys.length)];
    return randomColor;
  }

  void handlecontentTextChange() {
    setState(() {
      noteTitle = _contentcontroller.text.trim();
    });
  }

  @override
  void initState() {
    super.initState();
    noteColor = getRandomColor();
    _titlecontroller.addListener(handleTitleTextChange);
    _contentcontroller.addListener(handlecontentTextChange);
  }

  void _saveNote() {
    final String title = _titlecontroller.text;
    final String content = _contentcontroller.text;
    if (title.isNotEmpty && content.isNotEmpty) {
      //CREATE A NEW NOTE INSTANCE
      final Note note = Note(title: title, content: content, color: noteColor);
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      //SAVE THE NOTE TO FIRESTORE
      FirebaseFirestore.instance
          .collection("notes-$uid")
          .doc(uid)
          .collection("notesinfo")
          .add(note.toMap());
      CustomSnackbar(
        message: "Note saved successfully",
        icon: Icons.check,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ).show(context);
    } else {
      // Show an error message if any of the fields are empty
      CustomSnackbar(
        message: "Please fill in all the fields",
        icon: Icons.error,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _saveNote();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomNavBar()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(NoteColors[this.noteColor]!['l']!.toInt()),
        appBar: AppBar(
          title: Text("Add Note"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CustomNavBar()),
                  (route) => false);
              _saveNote();
            },
          ),
          elevation: 0,
          backgroundColor: Color(NoteColors[this.noteColor]!['b']!.toInt()),
          actions: [
            IconButton(
                onPressed: () => handleColor(context),
                icon: Icon(Icons.palette))
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _titlecontroller,
                maxLength: 31,
                maxLines: 1,
                style: GoogleFonts.roboto(fontSize: 30),
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold, fontSize: 30),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 24)),
              ),
              NoteEntry(
                textFieldController: _contentcontroller,
              )
            ],
          ),
        )),
      ),
    );
  }

  void handleColor(currentContext) {
    showDialog(
        context: currentContext,
        builder: (context) => ColorPalette(
              parentContext: currentContext,
            )).then((value) {
      if (value != null) {
        setState(() {
          noteColor = value;
        });
      }
    });
  }
}
