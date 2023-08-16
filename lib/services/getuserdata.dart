import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    var data = await _firestore
        .collection("notes-$uid")
        .doc(uid)
        .collection("userinfo")
        .get(GetOptions(source: Source.cache));

    Map<String, dynamic> userData = {};

    data.docs.forEach((doc) {
      userData = doc.data();
    });

    return userData;
  }
}
