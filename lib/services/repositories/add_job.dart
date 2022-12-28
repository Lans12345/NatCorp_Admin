import 'package:cloud_firestore/cloud_firestore.dart';

Future addJob(String name) async {
  final docUser = FirebaseFirestore.instance.collection('Job').doc();

  var dt = DateTime.now();

  final json = {
    'name': name,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'date': dt.month,
  };

  await docUser.set(json);
}
