import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const YuvaSpaceApp());
}

class YuvaSpaceApp extends StatelessWidget {
  const YuvaSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YuvaSpace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}