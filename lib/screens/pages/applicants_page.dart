import 'package:flutter/material.dart';

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
        appBar: AppbarWidget('Applicants'));
  }
}
