import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/drawer_widget.dart';

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
        appBar: AppbarWidget('Interview History'));
  }
}
