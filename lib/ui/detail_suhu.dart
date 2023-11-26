import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/api/data'));

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['suhu'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.blue, // Warna untuk data suhu
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['humid'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.green, // Warna untuk data kelembaban
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['lux'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.orange, // Warna untuk data kelembaban
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
            ],
            // Konfigurasi lainnya seperti borderData, gridData, dan titlesData
          ),
        ),
      ),
    );
  }
}
