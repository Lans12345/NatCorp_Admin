import 'package:flutter/material.dart';

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
        appBar: AppbarWidget('Users'));
  }
}
