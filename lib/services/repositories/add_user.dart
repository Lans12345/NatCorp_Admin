import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addAdmin(String name, String email) async {
  final docUser = FirebaseFirestore.instance
      .collection('Admin')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  var dt = DateTime.now();

  final json = {
    'name': name,
    'email': email,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'date': dt.month,
  };

  await docUser.set(json);
}
