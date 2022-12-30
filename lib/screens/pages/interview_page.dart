import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:intl/intl.dart';
import 'package:nat_corp_admin/calls/join_screen.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/drawer_widget.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

class InterviewPage extends StatelessWidget {
  InterviewPage({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      drawer: const DrawerWidget(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title:
            TextRegular(text: 'Interviews', fontSize: 18, color: Colors.white),
        backgroundColor: KgreyColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Interviews')
              .where('myId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('type', isEqualTo: 'Ongoing')
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
                      onPressed: () {
                        box.write(
                            'meetingId', data.docs[index]['interviewCode']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => VideoSDKQuickStart()));
                      },
                      icon: const Icon(
                        Icons.video_call_outlined,
                        size: 32,
                        color: Colors.blue,
                      ),
                    ),
                    title: TextRegular(
                        text:
                            'Application for: ' + data.docs[index]['position'],
                        fontSize: 14,
                        color: Colors.black),
                    subtitle: TextRegular(
                        text:
                            '${data.docs[index]['userName']} - $formattedTime',
                        fontSize: 10,
                        color: Colors.grey),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data.docs[index]['userProfilePic']),
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
