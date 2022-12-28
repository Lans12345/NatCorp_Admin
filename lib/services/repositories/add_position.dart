import 'package:cloud_firestore/cloud_firestore.dart';

Future addCompany(
  String positionDetails,
  String position,
) async {
  final docUser = FirebaseFirestore.instance.collection('Position').doc();

  var dt = DateTime.now();

  final json = {
    'positionDetails': positionDetails,
    'position': position,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'date': dt.month,
  };

  await docUser.set(json);
}
