import 'package:flutter/material.dart';

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
    );
  }
}
