import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/screens/auth/createaccount.dart';
import 'package:notesapp/screens/homescreens/notesscreen/editnote.dart';

import 'package:notesapp/screens/homescreens/notesscreen/notespage.dart';
import 'package:notesapp/screens/homescreens/notesscreen/flippingcard.dart';
import 'package:notesapp/screens/homescreens/notesscreen/stickynote.dart';
import 'package:notesapp/widgeets/appdrawer.dart';
import 'package:notesapp/widgeets/colorpalatte.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool _isGridView = true;
  String? _selectedColor; // Track the selected color for filtering
  bool isCardFlipped = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        isCardFlipped = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //GETTING THE NOTEINO FROM FIRESTORE
  Future<Map<String, dynamic>> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    var data = await FirebaseFirestore.instance
        .collection("notes-$uid")
        .doc(uid)
        .collection("notesinfo")
        .get();
    Map<String, dynamic> userData = {};
    data.docs.forEach((doc) {
      userData[doc.id] = doc.data();
    });
    return userData;
  }

  Map<String, dynamic> filterByColor(
      Map<String, dynamic> userData, String? selectedColor) {
    if (selectedColor == null) {
      return userData;
    }
    return userData.entries
        .where((entry) => entry.value['color'] == selectedColor)
        .fold<Map<String, dynamic>>(
            {}, (previous, entry) => previous..[entry.key] = entry.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawers(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
              onPressed: () {
                handleColor(context);
              },
              icon: Icon(Icons.color_lens))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SvgPicture.asset(
                "assets/images/notes.svg",
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _selectedColor == null
                      ? SizedBox()
                      : _buildClearFilterButton(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: FutureBuilder<Map<String, dynamic>>(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitCubeGrid(
                            size: 50,
                            color: Colors.orange,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        final userData = snapshot.data!;
                        final filteredData =
                            filterByColor(userData, _selectedColor);
                        if (filteredData.isEmpty) {
                          return Center(
                            child: Text(
                              "Click on the below add icon to create your first note.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          );
                        }
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: _isGridView
                              ? _buildGridView(filteredData)
                              : _buildListView(filteredData),
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildClearFilterButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedColor = null;
          });
        },
        child: Text("Clear Filter"));
  }

  Widget _buildGridView(Map<String, dynamic> userData) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final noteData = userData.values.elementAt(index);
        final title = noteData["title"] ?? "";
        final color = noteData["color"] ?? Colors.white;
        final content = noteData["content"] ?? "";
        return FlippingCard(
          frontSide: _buildFrontSide(title, color),
          backSide: _buildBackSide(title, content, color, index, noteData),
        );
      },
    );
  }

  Widget _buildBackSide(
      String title, String content, String color, int index, var noteData) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationX(pi),
      child: GestureDetector(
        onTap: () async {
          final User? user = FirebaseAuth.instance.currentUser;
          final uid = user!.uid;
          final QuerySnapshot<Map<String, dynamic>> snapshot =
              await FirebaseFirestore.instance
                  .collection("notes-$uid")
                  .doc(uid)
                  .collection("notesinfo")
                  .get();
          final noteId = snapshot.docs[index].id;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditNote(
                        noteData: noteData,
                        noteId: noteId,
                      )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // Customize the color for the back side
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(NoteColors[color]!['l']!.toInt()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(NoteColors[color]!['b']!.toInt()),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            title.length > 10
                                ? '${title.substring(0, 10)}....'
                                : title,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(NoteColors[color]!['b']!.toInt()),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              content.length > 40
                                  ? '${content.substring(0, 40)}....'
                                  : content,
                              maxLines: 4,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -7,
                top: -2,
                child: Image.asset(
                  "assets/images/pin.png",
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontSide(String title, String color) {
    return StickyNote(
      color: Color(NoteColors[color]!['b']!.toInt()),
      child: Text(
        title.length > 15
            ? '${title.substring(0, 10)}....'.toUpperCase()
            : title.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Change the text color as needed
        ),
      ),
    );
  }

  Widget _buildListView(Map<String, dynamic> userData) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 15,
      ),
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final noteData = userData.values.elementAt(index);
        final title = noteData["title"] ?? "";
        final color = noteData["color"] ?? Colors.white;
        final content = noteData["content"] ?? "";
        return GestureDetector(
          onTap: () async {
            final User? user = FirebaseAuth.instance.currentUser;
            final uid = user!.uid;
            final QuerySnapshot<Map<String, dynamic>> snapshot =
                await FirebaseFirestore.instance
                    .collection("notes-$uid")
                    .doc(uid)
                    .collection("notesinfo")
                    .get();
            final noteId = snapshot.docs[index].id;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditNote(
                          noteData: noteData,
                          noteId: noteId,
                        )));
          },
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(NoteColors[color]!['l']!.toInt()),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 30, top: 8, bottom: 8),
                  title: Text(
                    title.length > 40 ? '${title.substring(0, 40)}....' : title,
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    content.length > 40
                        ? '${content.substring(0, 40)}....'
                        : content,
                    maxLines: 4,
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                top: -2,
                child: Image.asset(
                  "assets/images/pin.png",
                  height: 50,
                ),
              )
            ],
          ),
        );
      },
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
          _selectedColor = value;
        });
      }
    });
  }
}
