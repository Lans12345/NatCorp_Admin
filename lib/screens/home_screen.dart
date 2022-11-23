import 'package:flutter/material.dart';
import 'package:nat_corp_admin/widgets/app_bar.dart';
import 'package:nat_corp_admin/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Dashboard'));
  }
}
