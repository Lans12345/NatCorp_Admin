import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({Key? key}) : super(key: key);

  @override
  State<ApplicantsPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<ApplicantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Applicants'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Applications')
              .where('status', isEqualTo: 'Pending')
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
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      leading: TextBold(
                                          text: 'Accept & Schedule a Meeting',
                                          fontSize: 14,
                                          color: Colors.green),
                                      trailing: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      onTap: (() {
                                        FirebaseFirestore.instance
                                            .collection('Applications')
                                            .doc(data.docs[index].id)
                                            .update({'status': 'Rejected'});
                                        Navigator.of(context).pop();
                                      }),
                                      leading: TextBold(
                                          text: 'Reject Application',
                                          fontSize: 14,
                                          color: Colors.red),
                                      trailing: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
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
                              padding: EdgeInsets.all(10.0),
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
