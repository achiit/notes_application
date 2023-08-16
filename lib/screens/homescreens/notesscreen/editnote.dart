import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/models/notemodel.dart';
import 'package:notesapp/screens/homescreens/notesscreen/noteentry.dart';
import 'package:notesapp/widgeets/colorpalatte.dart';
import 'package:notesapp/widgeets/customalertdialog.dart';
import 'package:notesapp/widgeets/customnavbar.dart';
import 'package:notesapp/widgeets/customsnackbar.dart';

class EditNote extends StatefulWidget {
  final Map<String, dynamic> noteData;
  final String noteId;
  EditNote({super.key, required this.noteData, required this.noteId});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late String noteColor;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteData["title"] ?? "";
    contentController.text = widget.noteData["content"] ?? "";

    noteColor = widget.noteData["color"] ?? "white";
  }

  void _saveNote() {
    final String title = _titleController.text.trim();
    final String content = contentController.text.trim();
    if (title.isNotEmpty && content.isNotEmpty) {
      final Note note = Note(title: title, content: content, color: noteColor);
      final User? user = FirebaseAuth.instance.currentUser;
      final uid = user!.uid;
      try {
        //CHECKING WHETHER THE NOTE EXISTS OR NOT
        bool isExistingNote = widget.noteData.isNotEmpty;
        if (isExistingNote) {
          //UPDATING THE EXISTING NOTE
          FirebaseFirestore.instance
              .collection("notes-$uid")
              .doc(uid)
              .collection("notesinfo")
              .doc(widget.noteId)
              .update(note.toMap());
          CustomSnackbar(
            message: "Note saved successfully",
            icon: Icons.check,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          ).show(context);
        } else {
          //ADD A NEW NOTE
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
        }
      } catch (error) {
        CustomSnackbar(
          message: "Failed to save the note",
          icon: Icons.error,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ).show(context);
      }
    } else {
      //SHOW AN ERROR MESSAGE IF ANY FIELDS ARE EMPTY
      CustomSnackbar(
        message: "Please fill in all the fields",
        icon: Icons.error,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ).show(context);
    }
  }

  void _deleteNote() {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    try {
      FirebaseFirestore.instance
          .collection("notes-$uid")
          .doc(uid)
          .collection("notesinfo")
          .doc(widget.noteId)
          .delete();
      CustomSnackbar(
        message: "Note deleted successfully",
        icon: Icons.delete,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ).show(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomNavBar()),
          (route) => false);
    } catch (error) {
      CustomSnackbar(
        message: "Error Occured",
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
          title: Text("Edit Note"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              _saveNote();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CustomNavBar()),
                  (route) => false);
            },
          ),
          elevation: 0,
          backgroundColor: Color(NoteColors[this.noteColor]!['b']!.toInt()),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomAlert(
                          title: "Delete Note",
                          title1: "Are you sure you want to delete the note?",
                          title2: "Delete Note",
                          onpressed: () {
                            _deleteNote();
                          },
                        ));
              },
              icon: Icon(
                Icons.delete,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                handleColor(context);
              },
              icon: Icon(
                Icons.palette,
                size: 30,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _titleController,
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
              textFieldController: contentController,
            )
          ]),
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
