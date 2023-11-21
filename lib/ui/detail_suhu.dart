import 'package:flutter/material.dart';

class Detail_sensor extends StatefulWidget {
  const Detail_sensor({super.key});

  @override
  State<Detail_sensor> createState() => _Detail_sensorState();
}

class _Detail_sensorState extends State<Detail_sensor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sensor'),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
      ),
    );
  }
}
