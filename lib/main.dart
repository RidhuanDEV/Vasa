import 'package:flutter/material.dart';
import 'package:vasa/screens/grafik.dart';
import 'package:vasa/screens/homepage.dart';
import 'package:vasa/screens/laporan.dart';
import 'package:vasa/screens/mengelola_rekening.dart';
import 'package:vasa/screens/profile.dart';
import 'package:vasa/global.dart';
import 'package:vasa/screens/tambah_rekening.dart';
import 'package:vasa/screens/transaksi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final List<Widget> _children = [
    const HomePage(),
    const GrafikScreen(),
    const LaporanPage(),
    const ProfilePage(),
    const MengelolaRekening(),
    const TambahRekening(),
    const Transaksi(),
  ];

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex =
          index; // Mengatur nilai currentIndex dari global.dart
    });
  }

  Widget _buildAppBar() {
    if (Globals.currentIndex == 0) {
      return AppBar(
        title: const Text('Pengelola Keuangan'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else if (Globals.currentIndex == 1) {
      return AppBar(
        title: const Center(
          child: Text('Grafik Keuangan', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else {
      return const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar() as PreferredSizeWidget,
      body: _children[Globals.currentIndex],
      floatingActionButton: (Globals.currentIndex != 4 &&
              Globals.currentIndex != 5 &&
              Globals.currentIndex != 6)
          ? FloatingActionButton(
              onPressed: () {
                onTabTapped(6);
              },
              backgroundColor: Colors.cyan,
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: (Globals.currentIndex != 4 &&
              Globals.currentIndex != 5 &&
              Globals.currentIndex != 6)
          ? BottomAppBar(
              color: Colors.cyan,
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.note, color: Colors.white),
                    onPressed: () {
                      onTabTapped(0);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.bar_chart, color: Colors.white),
                    onPressed: () {
                      onTabTapped(1);
                    },
                  ),
                  const SizedBox(
                      width: 40), // Tempat untuk floating action button
                  IconButton(
                    icon: const Icon(Icons.report, color: Colors.white),
                    onPressed: () {
                      onTabTapped(2);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      onTabTapped(3);
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
