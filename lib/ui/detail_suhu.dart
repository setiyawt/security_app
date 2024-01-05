import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailSuhu extends StatefulWidget {
  const DetailSuhu({Key? key}) : super(key: key);

  @override
  State<DetailSuhu> createState() => _DetailSuhuState();
}

class _DetailSuhuState extends State<DetailSuhu> {
  late Future<List<FlSpot>> futureChartData;

  @override
  void initState() {
    super.initState();
    futureChartData = fetchData();
  }

  Future<List<FlSpot>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://securityappitenas.000webhostapp.com/security-app/rataratahariterakhir.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<FlSpot> chartData = [];

      for (var i = 0; i < data.length; i++) {
        chartData.add(FlSpot(i.toDouble(), data[i]['f1_score']));
      }

      return chartData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Detection',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1C2321),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<FlSpot>>(
          future: futureChartData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ChartWidget(spots: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const ChartWidget({required this.spots});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        minX: 0,
        maxX: spots.length.toDouble() - 1,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
