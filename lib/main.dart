import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:security_system/ui/home.dart';
import 'package:security_system/ui/login_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyApp',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
