import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vasa/screens/akun.dart';
import 'package:vasa/screens/grafik.dart';
import 'package:vasa/screens/homepage.dart';
import 'package:vasa/screens/laporan.dart';
import 'package:vasa/screens/mengelola_rekening.dart';
import 'package:vasa/screens/pengaturan.dart';
import 'package:vasa/screens/profile.dart';
import 'package:vasa/global.dart';
import 'package:vasa/screens/tambah_rekening.dart';
import 'package:vasa/screens/transaksi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  DateTime _homePageDate = DateTime.now();

  final List<Widget> _children = [
    HomePage(initialDate: DateTime.now()),
    const GrafikScreen(),
    const LaporanPage(),
    const ProfilePage(),
    const MengelolaRekening(),
    const TambahRekening(),
    const Transaksi(),
    const Pengaturan(),
    const AkunPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index; // Mengatur nilai currentIndex dari global.dart
      if (index == 0) {
        _homePageDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        _children[0] = HomePage(initialDate: _homePageDate);
      }
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
      bottomNavigationBar: (Globals.currentIndex != 4 &&
              Globals.currentIndex != 5 &&
              Globals.currentIndex != 6 &&
              Globals.currentIndex != 7)
          ? BottomAppBar(
              color: Colors.cyan,
              
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
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 32.0),
                    onPressed: () {
                      onTabTapped(6);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.report, color: Colors.white),
                    onPressed: () {
                      onTabTapped(2);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
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
