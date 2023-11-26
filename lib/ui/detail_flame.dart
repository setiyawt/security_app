import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetailFlame extends StatefulWidget {
  const DetailFlame({Key? key}) : super(key: key);

  @override
  _DetailFlameState createState() => _DetailFlameState();
}

class _DetailFlameState extends State<DetailFlame> {
  List<Map<String, dynamic>> data = [];
  String _range = 'Select Date Range';
  late DateTime selectedDate = DateTime.now(); // Initialize selectedDate

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      // Adjust the end date by adding one day to include the whole selected day
      DateTime adjustedEndDate = picked.end.add(Duration(days: 1));

      setState(() {
        if (picked.start == picked.end) {
          _range = DateFormat('dd/MM/yyyy').format(picked.start);
        } else {
          _range =
              '${DateFormat('dd/MM/yyyy').format(picked.start)} - ${DateFormat('dd/MM/yyyy').format(picked.end)}';
        }
        selectedDate = picked.start;
        fetchData(selectedDate, adjustedEndDate);
      });
    }
  }

  Future<void> fetchData(DateTime startDate, DateTime endDate) async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('7day-overview');

      QuerySnapshot dataQuerySnapshot = await dataCollection
          .where('time', isGreaterThanOrEqualTo: startDate)
          .where('time', isLessThan: endDate)
          .get();

      setState(() {
        data = dataQuerySnapshot.docs
            .map((DocumentSnapshot document) =>
                Map<String, dynamic>.from(document.data() as Map))
            .toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Example'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$_range',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date Range'),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.black,
              thickness: 1,
              indent: 5,
              endIndent: 90,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int j = 0; j < data.length; j++)
                            FlSpot(
                              j.toDouble(),
                              (data[j]['Temp'] ?? 0.0).toDouble(),
                            ),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: [
                          for (int j = 0; j < data.length; j++)
                            FlSpot(
                              j.toDouble(),
                              (data[j]['Gas'] ?? 0.0).toDouble(),
                            ),
                        ],
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: [
                          for (int j = 0; j < data.length; j++)
                            FlSpot(
                              j.toDouble(),
                              (data[j]['Flame'] ?? 0.0).toDouble(),
                            ),
                        ],
                        isCurved: true,
                        color: Colors.orange,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: [
                          for (int j = 0; j < data.length; j++)
                            FlSpot(
                              j.toDouble(),
                              (data[j]['Motion'] ?? 0.0).toDouble(),
                            ),
                        ],
                        isCurved: true,
                        color: Colors.pink,
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
