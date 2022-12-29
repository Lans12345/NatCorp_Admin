import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Interviews')
                .where('type', isEqualTo: 'History')
                .orderBy('dateTime')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            text: 'Date', fontSize: 16, color: Colors.black)),
                    DataColumn(
                        label: TextBold(
                            text: 'Interviewe',
                            fontSize: 16,
                            color: Colors.black)),
                    DataColumn(
                        label: TextBold(
                            text: 'Applicant',
                            fontSize: 16,
                            color: Colors.black)),
                  ], rows: [
                // row to set the values
                for (int i = 0; i < snapshot.data!.size; i++)
                  DataRow(cells: [
                    DataCell(
                      TextRegular(
                          text: data.docs[i]['date'],
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    DataCell(
                      TextRegular(
                          text: data.docs[i]['companyName'],
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    DataCell(
                      TextRegular(
                          text: data.docs[i]['userName'],
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ])
              ]);
            }),
      ),
    );
  }
}
