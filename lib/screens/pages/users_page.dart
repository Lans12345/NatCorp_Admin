import 'package:flutter/material.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Users'),
        body: SingleChildScrollView(
          child: DataTable(
              // datatable widget
              columns: [
                // column to set the name
                DataColumn(
                    label: TextBold(
                        text: 'No.', fontSize: 16, color: Colors.black)),
                DataColumn(
                    label: TextBold(
                        text: 'Name', fontSize: 16, color: Colors.black)),
                DataColumn(
                    label: TextBold(
                        text: 'Email', fontSize: 16, color: Colors.black)),
              ], rows: [
            // row to set the values
            for (int i = 0; i < 50; i++)
              DataRow(cells: [
                DataCell(
                  TextRegular(
                      text: i.toString(), fontSize: 14, color: Colors.grey),
                ),
                DataCell(
                  TextRegular(
                      text: 'Lance Olana', fontSize: 14, color: Colors.grey),
                ),
                DataCell(
                  TextRegular(
                      text: 'olana@gmail.com',
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ])
          ]),
        ));
  }
}
