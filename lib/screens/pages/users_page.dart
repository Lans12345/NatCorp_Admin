import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nat_corp_admin/services/repositories/add_ban.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/button_widget.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<UsersPage> {
  bool isBanned = false;
  var dropDownValue = 1;

  late String reason = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Users'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: KgreyColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: DropdownButton(
                      underline: Container(color: Colors.transparent),
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: dropDownValue,
                      items: [
                        DropdownMenuItem(
                          onTap: () {
                            setState(() {
                              isBanned = false;
                            });
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Active",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            setState(() {
                              isBanned = true;
                            });
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Banned",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('isBanned', isEqualTo: isBanned)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return DataTable(
                        // datatable widget
                        columns: [
                          // column to set the name
                          DataColumn(
                              label: TextBold(
                                  text: 'No.',
                                  fontSize: 16,
                                  color: Colors.black)),
                          DataColumn(
                              label: TextBold(
                                  text: 'Name',
                                  fontSize: 16,
                                  color: Colors.black)),
                          DataColumn(
                              label: TextBold(
                                  text: 'Email',
                                  fontSize: 16,
                                  color: Colors.black)),
                        ], rows: [
                      // row to set the values
                      for (int i = 0; i < data.size; i++)
                        isBanned == false
                            ? DataRow(cells: [
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: SizedBox(
                                                            height: 220,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Reason',
                                                                    ),
                                                                    onChanged:
                                                                        (_input) {
                                                                      reason =
                                                                          _input;
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                ButtonWidget(
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .doc(data
                                                                              .docs[i]
                                                                              .id)
                                                                          .update({
                                                                        'isBanned':
                                                                            true,
                                                                      });

                                                                      addBan(
                                                                          data.docs[i]['firstName'] +
                                                                              ' ' +
                                                                              data.docs[i][
                                                                                  'secondName'],
                                                                          data.docs[i]
                                                                              [
                                                                              'email'],
                                                                          data
                                                                              .docs[
                                                                                  i]
                                                                              .id,
                                                                          reason,
                                                                          data.docs[i]
                                                                              [
                                                                              'birthdate']);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: 'User banned succesfully!');
                                                                    },
                                                                    text:
                                                                        'Continue'),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                leading: TextBold(
                                                    text: 'Ban User',
                                                    fontSize: 15,
                                                    color: Colors.red),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.red),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: i.toString(),
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: SizedBox(
                                                            height: 220,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Reason',
                                                                    ),
                                                                    onChanged:
                                                                        (_input) {
                                                                      reason =
                                                                          _input;
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                ButtonWidget(
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .doc(data
                                                                              .docs[i]
                                                                              .id)
                                                                          .update({
                                                                        'isBanned':
                                                                            true,
                                                                      });
                                                                      addBan(
                                                                          data.docs[i]['firstName'] +
                                                                              ' ' +
                                                                              data.docs[i][
                                                                                  'secondName'],
                                                                          data.docs[i]
                                                                              [
                                                                              'email'],
                                                                          data
                                                                              .docs[
                                                                                  i]
                                                                              .id,
                                                                          reason,
                                                                          data.docs[i]
                                                                              [
                                                                              'birthdate']);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: 'User banned succesfully!');
                                                                    },
                                                                    text:
                                                                        'Continue'),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                leading: TextBold(
                                                    text: 'Ban User',
                                                    fontSize: 15,
                                                    color: Colors.red),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.red),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: data.docs[i]['firstName'] +
                                            ' ' +
                                            data.docs[i]['secondName'],
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: SizedBox(
                                                            height: 220,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Reason',
                                                                    ),
                                                                    onChanged:
                                                                        (_input) {
                                                                      reason =
                                                                          _input;
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                ButtonWidget(
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .doc(data
                                                                              .docs[i]
                                                                              .id)
                                                                          .update({
                                                                        'isBanned':
                                                                            true,
                                                                      });
                                                                      addBan(
                                                                          data.docs[i]['firstName'] +
                                                                              ' ' +
                                                                              data.docs[i][
                                                                                  'secondName'],
                                                                          data.docs[i]
                                                                              [
                                                                              'email'],
                                                                          data
                                                                              .docs[
                                                                                  i]
                                                                              .id,
                                                                          reason,
                                                                          data.docs[i]
                                                                              [
                                                                              'birthdate']);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: 'User banned succesfully!');
                                                                    },
                                                                    text:
                                                                        'Continue'),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                leading: TextBold(
                                                    text: 'Ban User',
                                                    fontSize: 15,
                                                    color: Colors.red),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.red),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: data.docs[i]['email'],
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                              ])
                            : DataRow(cells: [
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(data.docs[i].id)
                                                      .update({
                                                    'isBanned': false,
                                                  });

                                                  Navigator.of(context).pop();

                                                  FirebaseFirestore.instance
                                                      .collection('Ban')
                                                      .doc(data.docs[i].id)
                                                      .delete();

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'User unbanned succesfully!');
                                                },
                                                leading: TextBold(
                                                    text: 'Unbanned User',
                                                    fontSize: 15,
                                                    color: Colors.green),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.green),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: i.toString(),
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(data.docs[i].id)
                                                      .update({
                                                    'isBanned': false,
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('Ban')
                                                      .doc(data.docs[i].id)
                                                      .delete();
                                                  Navigator.of(context).pop();

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'User unbanned succesfully!');
                                                },
                                                leading: TextBold(
                                                    text: 'Unbanned User',
                                                    fontSize: 15,
                                                    color: Colors.green),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.green),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: data.docs[i]['firstName'] +
                                            ' ' +
                                            data.docs[i]['secondName'],
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListTile(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(data.docs[i].id)
                                                      .update({
                                                    'isBanned': false,
                                                  });
                                                  Navigator.of(context).pop();

                                                  FirebaseFirestore.instance
                                                      .collection('Ban')
                                                      .doc(data.docs[i].id)
                                                      .delete();

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'User unbanned succesfully!');
                                                },
                                                leading: TextBold(
                                                    text: 'Unbanned User',
                                                    fontSize: 15,
                                                    color: Colors.green),
                                                trailing: const Icon(
                                                    Icons.close,
                                                    color: Colors.green),
                                              ),
                                            );
                                          });
                                    },
                                    child: TextRegular(
                                        text: data.docs[i]['email'],
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                              ])
                    ]);
                  }),
            ],
          ),
        ));
  }
}
