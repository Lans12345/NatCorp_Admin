import 'package:cloud_firestore/cloud_firestore.dart';

Future addBan(String name, String email, String uid, String message) async {
  final docUser = FirebaseFirestore.instance.collection('Ban').doc(uid);

  var dt = DateTime.now();

  final json = {
    'name': name,
    'email': email,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'date': dt.month,
    'message': message,
  };

  await docUser.set(json);
}
