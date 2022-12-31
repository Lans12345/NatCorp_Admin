import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nat_corp_admin/screens/pages/add_company_screen.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/button_widget.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<CompaniesPage> {
  late String upPos;
  late String upDesc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Kgradient1,
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddCompany()));
        }),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Companies'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Company').snapshots(),
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
                            builder: (context) {
                              return SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('Company')
                                            .doc(data.docs[index].id)
                                            .delete();
                                        Fluttertoast.showToast(
                                            msg: 'Deleted Succesfully!');
                                        Navigator.of(context).pop();
                                      },
                                      leading: TextRegular(
                                          text: 'Delete',
                                          fontSize: 16,
                                          color: Colors.red),
                                      trailing: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 10),
                                                        child: TextFormField(
                                                          onChanged: (_input) {
                                                            upPos = _input;
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Available Positions:',
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 10, 20, 10),
                                                        child: TextFormField(
                                                          onChanged: (_input) {
                                                            upDesc = _input;
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Position Description:',
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      ButtonWidget(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Company')
                                                                .doc(data
                                                                    .docs[index]
                                                                    .id)
                                                                .update({
                                                              'position': upPos,
                                                              'positionDetails':
                                                                  upDesc
                                                            });
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Updated Succesfully!');
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          text: 'Update')
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      leading: TextRegular(
                                          text: 'Update',
                                          fontSize: 16,
                                          color: Colors.blue),
                                      trailing: const Icon(
                                        Icons.update,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                  data.docs[index]['companyLogo']),
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
                                      'Name: ${data.docs[index]['companyName']}',
                                  fontSize: 14,
                                  color: Colors.black),
                              TextRegular(
                                  text:
                                      'Address: ${data.docs[index]['companyAddress']}',
                                  fontSize: 12,
                                  color: Colors.grey),
                              const SizedBox(
                                height: 5,
                              ),
                              TextBold(
                                  text: 'Available positions',
                                  fontSize: 12,
                                  color: Colors.black),
                              TextRegular(
                                  text: '${data.docs[index]['position']}',
                                  fontSize: 10,
                                  color: Colors.grey),
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
