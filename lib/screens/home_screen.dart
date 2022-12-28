import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nat_corp_admin/widgets/app_bar.dart';
import 'package:nat_corp_admin/widgets/drawer_widget.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/data/chart_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getTotalUsers();
    getTotalComp();
    getMonth1();
    getMonth2();
    getMonth3();
    getMonth4();
    getMonth5();
    getMonth6();
    getMonth7();
    getMonth8();
    getMonth9();
    getMonth10();
    getMonth11();
    getMonth12();
  }

  int totalUsers = 0;

  getTotalUsers() async {
    // Use provider
    var collection = FirebaseFirestore.instance.collection('users');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        totalUsers = querySnapshot.size;
      });
    }
  }

  int totalComp = 0;

  getTotalComp() async {
    // Use provider
    var collection = FirebaseFirestore.instance.collection('Company');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        setState(() {
          totalComp = querySnapshot.size;
        });
      });
    }
  }

  late int month1 = 0;

  getMonth1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 1);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month1 = querySnapshot.size;
        }
      });
    }
  }

  late int month2 = 0;

  getMonth2() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 2);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month2 = querySnapshot.size;
        }
      });
    }
  }

  late int month3 = 0;

  getMonth3() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 3);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month3 = querySnapshot.size;
        }
      });
    }
  }

  late int month4 = 0;

  getMonth4() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 4);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month4 = querySnapshot.size;
        }
      });
    }
  }

  late int month5 = 0;

  getMonth5() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 5);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month5 = querySnapshot.size;
        }
      });
    }
  }

  late int month6 = 0;

  getMonth6() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 6);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month6 = querySnapshot.size;
        }
      });
    }
  }

  late int month7 = 0;

  getMonth7() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 7);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month7 = querySnapshot.size;
        }
      });
    }
  }

  late int month8 = 0;

  getMonth8() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 8);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month8 = querySnapshot.size;
        }
      });
    }
  }

  late int month9 = 0;

  getMonth9() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 9);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month1 = querySnapshot.size;
        }
      });
    }
  }

  late int month10 = 0;

  getMonth10() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 10);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month10 = querySnapshot.size;
        }
      });
    }
  }

  late int month11 = 0;

  getMonth11() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 11);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month11 = querySnapshot.size;
        }
      });
    }
  }

  late int month12 = 0;

  getMonth12() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Interviews')
        .where('date', isEqualTo: 12);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          month12 = querySnapshot.size;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(01, month1.toDouble()),
      ChartData(02, month2.toDouble()),
      ChartData(03, month3.toDouble()),
      ChartData(04, month4.toDouble()),
      ChartData(05, month5.toDouble()),
      ChartData(06, month6.toDouble()),
      ChartData(07, month7.toDouble()),
      ChartData(08, month8.toDouble()),
      ChartData(09, month9.toDouble()),
      ChartData(10, month10.toDouble()),
      ChartData(11, month11.toDouble()),
      ChartData(12, month12.toDouble()),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Dashboard'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.groups_rounded,
                              size: 58,
                            ),
                            TextBold(
                                text: totalUsers.toString(),
                                fontSize: 32,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            TextRegular(
                                text: 'No. of Users',
                                fontSize: 14,
                                color: Colors.grey),
                          ],
                        ),
                        height: 175,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.business_center_rounded,
                              size: 58,
                            ),
                            TextBold(
                                text: totalComp.toString(),
                                fontSize: 32,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            TextRegular(
                                text: 'No. of Companies',
                                fontSize: 14,
                                color: Colors.grey),
                          ],
                        ),
                        height: 175,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: TextBold(
                    text: 'No. of Interviews',
                    fontSize: 18,
                    color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: SfCartesianChart(series: <ChartSeries>[
                      // Renders spline chart

                      SplineSeries<ChartData, int>(
                          name: 'No. of Interviews',
                          legendItemText: 'No. of Interviews',
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
