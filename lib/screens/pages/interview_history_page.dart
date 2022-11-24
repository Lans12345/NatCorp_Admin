import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/text_widget.dart';

class InterviewHistoryPage extends StatefulWidget {
  const InterviewHistoryPage({Key? key}) : super(key: key);

  @override
  State<InterviewHistoryPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<InterviewHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Interview History'),
      body: SingleChildScrollView(
        child: DataTable(
            // datatable widget
            columns: [
              // column to set the name
              DataColumn(
                  label: TextBold(
                      text: 'Date', fontSize: 16, color: Colors.black)),
              DataColumn(
                  label: TextBold(
                      text: 'Interviewe', fontSize: 16, color: Colors.black)),
              DataColumn(
                  label: TextBold(
                      text: 'Applicant', fontSize: 16, color: Colors.black)),
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
                TextRegular(text: 'John Doe', fontSize: 14, color: Colors.grey),
              ),
            ])
        ]),
      ),
    );
  }
}
