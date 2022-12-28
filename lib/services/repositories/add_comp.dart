import 'package:cloud_firestore/cloud_firestore.dart';

Future addCompany(
  String companyName,
  String companyLogo,
  String positionDetails,
  String position,
  String companyAddress,
) async {
  final docUser = FirebaseFirestore.instance.collection('Company').doc();

  var dt = DateTime.now();

  final json = {
    'companyName': companyName,
    'companyAddress': companyAddress,
    'companyLogo': companyLogo,
    'positionDetails': positionDetails,
    'position': position,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'type': 'Ongoing',
    'date': dt.month,
  };

  await docUser.set(json);
}
