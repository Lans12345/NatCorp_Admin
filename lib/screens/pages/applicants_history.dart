import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nat_corp_admin/screens/pages/document_page.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';
import 'package:videosdk/videosdk.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class ApplicantsHistory extends StatefulWidget {
  const ApplicantsHistory({Key? key}) : super(key: key);

  @override
  State<ApplicantsHistory> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<ApplicantsHistory> {
  late final void Function() onCreateMeetingButtonPressed;
  late String interviewCode = '';

  late String dateAndTime = '';

  String meetingId = "";

  final box = GetStorage();

  // late Room room;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Applicant History'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Applications')
              .where('status', isEqualTo: 'Accepted')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
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
                itemCount: snapshot.data!.size,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: (() {
                        showModalBottomSheet(
                            context: context,
                            builder: ((context) {
                              return SizedBox(
                                height: 100,
                                child: ListTile(
                                  onTap: (() {
                                    box.write('data', data.docs[index]);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DocumentPage()));
                                  }),
                                  leading: TextBold(
                                      text: 'Applicant Documents',
                                      fontSize: 14,
                                      color: Colors.blue),
                                  trailing: const Icon(
                                    Icons.attach_file,
                                    color: Colors.blue,
                                  ),
                                ),
                              );
                            }));
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                minRadius: 25,
                                maxRadius: 25,
                                backgroundImage:
                                    NetworkImage(data.docs[index]['profile']),
                              ),
                            ),
                            height: 100,
                            width: 100,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBold(
                                  text:
                                      'Name: ${data.docs[index]['firstName'] + ' ' + data.docs[index]['lastName']}',
                                  fontSize: 14,
                                  color: Colors.black),
                              TextRegular(
                                  text:
                                      'Contact Number: ${data.docs[index]['contactNumber']}',
                                  fontSize: 12,
                                  color: Colors.grey),
                              TextRegular(
                                  text:
                                      'Email Address: ${data.docs[index]['email']}',
                                  fontSize: 12,
                                  color: Colors.grey),
                              const SizedBox(
                                height: 5,
                              ),
                              TextBold(
                                  text:
                                      'Preffered Job: ${data.docs[index]['positionDesired']}',
                                  fontSize: 12,
                                  color: Colors.black),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}
