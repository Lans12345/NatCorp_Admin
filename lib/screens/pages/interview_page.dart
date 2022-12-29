import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF075009),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Interviews')
              .where('myId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('type', isEqualTo: 'Accepted')
              // .orderBy('dateTime')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting');
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: ((context, index) {
                DateTime created = data.docs[index]['dateTime'].toDate();

                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(created);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.video_call_outlined,
                        size: 32,
                        color: Colors.blue,
                      ),
                    ),
                    title: TextRegular(
                        text: data.docs[index]['position'],
                        fontSize: 14,
                        color: Colors.black),
                    subtitle: TextRegular(
                        text:
                            '${data.docs[index]['companyName']} - $formattedTime',
                        fontSize: 10,
                        color: Colors.grey),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data.docs[index]['companyLogo']),
                      minRadius: 25,
                      maxRadius: 25,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
