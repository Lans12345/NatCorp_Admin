import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:nat_corp_admin/auth/login_page.dart.dart';
import 'package:nat_corp_admin/screens/home_screen.dart';
import 'package:nat_corp_admin/screens/pages/applicants_page.dart';
import 'package:nat_corp_admin/screens/pages/companies_page.dart';
import 'package:nat_corp_admin/screens/pages/interview_history_page.dart';
import 'package:nat_corp_admin/screens/pages/interview_page.dart';
import 'package:nat_corp_admin/screens/pages/users_page.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<DrawerWidget> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return SizedBox(
      width: 220,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            StreamBuilder<DocumentSnapshot>(
                stream: userData,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  dynamic data = snapshot.data;
                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: KgreyColor,
                    ),
                    accountEmail:
                        TextRegular(text: '', fontSize: 0, color: Colors.white),
                    accountName: TextBold(
                      text: data['name'],
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    currentAccountPicture: const CircleAvatar(
                      minRadius: 80,
                      maxRadius: 80,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: TextBold(
                text: 'Dashboard',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: TextBold(
                text: 'Users',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const UsersPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: TextBold(
                text: 'Companies',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CompaniesPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline_rounded),
              title: TextBold(
                text: 'Applicants',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ApplicantsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_call),
              title: TextBold(
                text: 'Interviews',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const InterviewPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: TextBold(
                text: 'Interview History',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const InterviewHistoryPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: TextBold(
                text: 'Logout',
                fontSize: 12,
                color: Colors.grey,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Logout Confirmation',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you sure you want to Logout?',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
