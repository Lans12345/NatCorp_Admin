import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nat_corp_admin/services/repositories/add_interview.dart';
import 'package:nat_corp_admin/widgets/button_widget.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({Key? key}) : super(key: key);

  @override
  State<ApplicantsPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<ApplicantsPage> {
  late String interviewCode = '';

  late String dateAndTime = '';
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
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: SizedBox(
                                                  height: 300,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                          text:
                                                              'Interview Details',
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 20),
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            label: TextBold(
                                                                text:
                                                                    'Interview Code',
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          onChanged: (_input) {
                                                            interviewCode =
                                                                _input;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 20),
                                                        child: Center(
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: 300,
                                                            child:
                                                                DateTimePicker(
                                                                    type: DateTimePickerType
                                                                        .dateTimeSeparate,
                                                                    dateMask:
                                                                        'd MMM, yyyy',
                                                                    initialValue:
                                                                        DateTime.now()
                                                                            .toString(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2000),
                                                                    lastDate: DateTime(
                                                                        2100),
                                                                    icon: const Icon(Icons
                                                                        .event),
                                                                    dateLabelText:
                                                                        'Intetview Date',
                                                                    timeLabelText:
                                                                        "Intetview Time",
                                                                    onChanged:
                                                                        (val) {
                                                                      dateAndTime =
                                                                          val;
                                                                    },
                                                                    validator:
                                                                        (val) {
                                                                      dateAndTime =
                                                                          val!;
                                                                      return null;
                                                                    },
                                                                    onSaved:
                                                                        (val) {
                                                                      dateAndTime =
                                                                          val!;
                                                                    }),
                                                          ),
                                                        ),
                                                      ),
                                                      ButtonWidget(
                                                          onPressed: () {
                                                            addInterview(
                                                                data.docs[index]
                                                                    [
                                                                    'companyName'],
                                                                data.docs[index]
                                                                    [
                                                                    'companyLogo'],
                                                                data.docs[index]
                                                                    [
                                                                    'companyId'],
                                                                '',
                                                                data.docs[index]
                                                                    [
                                                                    'positionDesired'],
                                                                data.docs[index]
                                                                    [
                                                                    'companyName'],
                                                                data.docs[index]
                                                                        [
                                                                        'firstName'] +
                                                                    ' ' +
                                                                    data.docs[index]
                                                                        [
                                                                        'lastName'],
                                                                data.docs[index]
                                                                    .id, // change to userId
                                                                interviewCode,
                                                                data.docs[index]
                                                                    ['profile'],
                                                                dateAndTime);

                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Applications')
                                                                .doc(data
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'status':
                                                                  'Accepted'
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            Fluttertoast.showToast(
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                msg:
                                                                    'Interview Code - $interviewCode\nSchedule: $dateAndTime');
                                                          },
                                                          text: 'Continue'),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                        // Navigator.of(context).pop();
                                      }),
                                      leading: TextBold(
                                          text: 'Accept & Schedule a Meeting',
                                          fontSize: 14,
                                          color: Colors.green),
                                      trailing: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const Divider(),
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
                                      trailing: const Icon(
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
