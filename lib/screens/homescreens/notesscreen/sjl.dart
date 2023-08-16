
  // Widget _buildGridView(Map<String, dynamic> userData) {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 8,
  //       mainAxisSpacing: 8,
  //     ),
  //     itemCount: userData.length,
  //     itemBuilder: (context, index) {
  //       final noteData = userData.values.elementAt(index);
  //       final title = noteData["title"] ?? "";
  //       final color = noteData["color"] ?? Colors.white;
  //       final content = noteData["content"] ?? "";
  //       return GestureDetector(
  //         onTap: () async {
  //           final User? user = FirebaseAuth.instance.currentUser;
  //           final uid = user!.uid;
  //           final QuerySnapshot<Map<String, dynamic>> snapshot =
  //               await FirebaseFirestore.instance
  //                   .collection("notes-$uid")
  //                   .doc(uid)
  //                   .collection("notesinfo")
  //                   .get();
  //           final noteId = snapshot.docs[index].id;

  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => EditNote(
  //                         noteData: noteData,
  //                         noteId: noteId,
  //                       )));
  //         },
  //         child: Stack(
  //           children: [
  //             Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               color: Color(NoteColors[color]!['l']!.toInt()),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       width: double.infinity,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Color(NoteColors[color]!['b']!.toInt()),
  //                         ),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(2.0),
  //                         child: Text(
  //                           title.length > 10
  //                               ? '${title.substring(0, 10)}....'
  //                               : title,
  //                           maxLines: 1,
  //                           textAlign: TextAlign.center,
  //                           style: GoogleFonts.poppins(
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 8,
  //                     ),
  //                     Expanded(
  //                       child: Container(
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                           border: Border.all(
  //                             color: Color(NoteColors[color]!['b']!.toInt()),
  //                           ),
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(4.0),
  //                           child: Text(
  //                             content.length > 40
  //                                 ? '${content.substring(0, 40)}....'
  //                                 : content,
  //                             maxLines: 4,
  //                             style: GoogleFonts.poppins(),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               left: -7,
  //               top: -2,
  //               child: Image.asset(
  //                 "assets/images/pin.png",
  //                 height: 50,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }