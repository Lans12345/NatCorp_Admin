import 'package:flutter/material.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<CompaniesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Kgradient1,
        onPressed: (() {}),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Companies'),
      body: ListView.builder(itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/fblogo.png'),
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
                      text: 'Name: Facebook Inc.',
                      fontSize: 14,
                      color: Colors.black),
                  TextRegular(
                      text: 'Address: Cagayan De Oro City',
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
                      text:
                          'Office Clerk, Graphic Designer, Network Engineer hahah',
                      fontSize: 12,
                      color: Colors.grey),
                ],
              ),
            ]),
          ),
        );
      })),
    );
  }
}
