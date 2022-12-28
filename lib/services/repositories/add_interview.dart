import 'package:cloud_firestore/cloud_firestore.dart';

Future addInterView(
  String companyName,
  String companyLogo,
  String companyId,
  String positionDetails,
  String position,
  String interviewe,
  String userName,
  String uid,
  String interviewCode,
  String userProfilePic,
) async {
  final docUser = FirebaseFirestore.instance.collection('Interviews').doc();

  var dt = DateTime.now();

  final json = {
    'companyName': companyName,
    'companyLogo': companyLogo,
    'companyId': companyId,
    'positionDetails': positionDetails,
    'position': position,
    'interviewe': interviewe,
    'userName': userName,
    'uid': uid,
    'interviewCode': interviewCode,
    'userProfilePic': userProfilePic,
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'type': 'Ongoing',
    'date': dt.month,
  };

  await docUser.set(json);
}