import 'package:flutter/material.dart';
import 'package:vasa/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Hapus const di sini
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
