import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:nat_corp_admin/screens/home_screen.dart';
import 'package:nat_corp_admin/screens/pages/applicants_page.dart';
import 'package:nat_corp_admin/screens/pages/companies_page.dart';
import 'package:nat_corp_admin/screens/pages/interview_history_page.dart';
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
    return SizedBox(
      width: 220,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: KgreyColor,
              ),
              accountEmail:
                  TextRegular(text: '', fontSize: 0, color: Colors.white),
              accountName: TextBold(
                text: 'Nat Corp',
                fontSize: 18,
                color: Colors.white,
              ),
              currentAccountPicture: const CircleAvatar(
                minRadius: 80,
                maxRadius: 80,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
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
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const LogInPage()));
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
