import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note {
  //variables for the model
  String title;
  String content;
  String color;
  final DateTime? createdAt;
  DateTime? modifiedAt;

  Note({
    required this.title,
    required this.content,
    required this.color,
    DateTime? createdAt,
    DateTime? modifiedAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "title": title,
      "color": color,
      "createdAt": createdAt!.millisecondsSinceEpoch,
      "modifiedAt": modifiedAt!.millisecondsSinceEpoch,
    };
  }

  static List<Note> fromQuery(QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.isNotEmpty ? toNotes(snapshot) : [];
}

List<Note> toNotes(QuerySnapshot<Map<String, dynamic>> query) =>
    query.docs.map((doc) => toNote(doc)).whereType<Note>().toList();

Note? toNote(DocumentSnapshot<Map<String, dynamic>> doc) => doc.exists
    ? Note(
        title: doc.data()!["title"],
        content: doc.data()!["content"],
        color: doc.data()!["color"],
        createdAt:
            DateTime.fromMicrosecondsSinceEpoch(doc.data()!['createdAt'] ?? 0),
        modifiedAt:
            DateTime.fromMicrosecondsSinceEpoch(doc.data()!["modifiedAt"] ?? 0))
    : null;
