import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class Detail_suhu extends StatefulWidget {
  const Detail_suhu({super.key});

  @override
  State<Detail_suhu> createState() => _Detail_suhuState();
}

class _Detail_suhuState extends State<Detail_suhu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sensor'),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
      ),
      body: RealtimeChart(),
    );
  }
}

class RealtimeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('7day-overview').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          List<String> dates = [];
          List<double> avgSuhuList = [];
          List<double> avgGasList = [];
          List<double> avgFlameList = [];
          List<double> avgMotionList = [];

          // Populate data lists
          for (int i = 0; i < documents.length; i++) {
            final Map<String, dynamic>? data =
                documents[i].data() as Map<String, dynamic>?;

            if (data != null && data.containsKey('date')) {
              dates.add(data['date']);
              avgSuhuList.add(calculateAverage(documents, i, 'suhu'));
              avgGasList.add(calculateAverage(documents, i, 'gas'));
              avgFlameList.add(calculateAverage(documents, i, 'flame'));
              avgMotionList.add(calculateAverage(documents, i, 'motion'));
            }
          }

          // Use either createLineChart or sampleData based on your requirement
          return LineChart(
            createLineChart(
                dates, avgSuhuList, avgGasList, avgFlameList, avgMotionList),
          );
          // or
          // return LineChart(sampleData(spots));
        }
      },
    );
  }

  double calculateAverage(
      List<DocumentSnapshot> documents, int index, String field) {
    double sum = 0;
    int validDocumentsCount = 0;

    // Calculate the average for the specified field at the given index
    Map<String, dynamic>? data =
        documents[index].data() as Map<String, dynamic>?;

    data?.forEach((key, value) {
      if (key == field) {
        sum += value;
        validDocumentsCount++;
      }
    });

    return validDocumentsCount > 0 ? sum / validDocumentsCount : 0;
  }

  LineChartData createLineChart(
    List<String> dates,
    List<double> avgSuhuList,
    List<double> avgGasList,
    List<double> avgFlameList,
    List<double> avgMotionList,
  ) {
    List<FlSpot> spotsSuhu = List.generate(
      avgSuhuList.length,
      (index) => FlSpot(index.toDouble(), avgSuhuList[index]),
    );

    List<FlSpot> spotsGas = List.generate(
      avgGasList.length,
      (index) => FlSpot(index.toDouble(), avgGasList[index]),
    );

    List<FlSpot> spotsFlame = List.generate(
      avgFlameList.length,
      (index) => FlSpot(index.toDouble(), avgFlameList[index]),
    );

    List<FlSpot> spotsMotion = List.generate(
      avgMotionList.length,
      (index) => FlSpot(index.toDouble(), avgMotionList[index]),
    );

    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spotsSuhu,
          isCurved: true,
          belowBarData: BarAreaData(show: false),
          color: Colors.red,
        ),
        LineChartBarData(
          spots: spotsGas,
          isCurved: true,
          belowBarData: BarAreaData(show: false),
          color: Colors.blue, // Customize the color for gas
        ),
        LineChartBarData(
          spots: spotsFlame,
          isCurved: true,
          belowBarData: BarAreaData(show: false),
          color: Colors.orange, // Customize the color for flame
        ),
        LineChartBarData(
          spots: spotsMotion,
          isCurved: true,
          belowBarData: BarAreaData(show: false),
          color: Colors.green, // Customize the color for motion
        ),
      ],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
      ),
      gridData: FlGridData(show: false),
    );
  }
}
