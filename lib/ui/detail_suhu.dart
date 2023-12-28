import 'package:flutter/material.dart';

class DetailSuhu extends StatefulWidget {
  const DetailSuhu({super.key});

  @override
  State<DetailSuhu> createState() => _DetailSuhuState();
}

class _DetailSuhuState extends State<DetailSuhu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Detection',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF1C2321),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
