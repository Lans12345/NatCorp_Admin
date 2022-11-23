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
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(01, 35),
      ChartData(02, 25),
      ChartData(03, 12),
      ChartData(04, 35),
      ChartData(05, 58),
      ChartData(06, 12),
      ChartData(07, 125),
      ChartData(08, 76),
      ChartData(09, 1),
      ChartData(10, 56),
      ChartData(11, 12),
      ChartData(12, 65),
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
                                text: '100', fontSize: 32, color: Colors.black),
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
                                text: '100', fontSize: 32, color: Colors.black),
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
