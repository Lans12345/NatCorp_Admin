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
      body: ListView.builder(itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(children: [
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    minRadius: 25,
                    maxRadius: 25,
                    backgroundImage: AssetImage('assets/images/profile.png'),
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
                      text: 'Name: John Doe',
                      fontSize: 14,
                      color: Colors.black),
                  TextRegular(
                      text: 'Contact Number: 09090104355',
                      fontSize: 12,
                      color: Colors.grey),
                  TextRegular(
                      text: 'Email Address: john@gmail.com',
                      fontSize: 12,
                      color: Colors.grey),
                  const SizedBox(
                    height: 5,
                  ),
                  TextBold(
                      text: 'Preffered Job: Office Clerk',
                      fontSize: 12,
                      color: Colors.black),
                ],
              ),
            ]),
          ),
        );
      })),
    );
  }
}
