import 'package:flutter/material.dart';
import 'package:vasa/botnav.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BotNav(),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
