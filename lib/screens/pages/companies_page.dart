import 'package:flutter/material.dart';

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
        backgroundColor: Colors.grey[200],
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Companies'));
  }
}
