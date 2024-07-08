import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vasa/screens/grafik.dart';
import 'package:vasa/screens/homepage.dart';
import 'package:vasa/screens/laporan.dart';
import 'package:vasa/screens/mengelola_rekening.dart';
import 'package:vasa/screens/profile.dart';
import 'package:vasa/global.dart';
import 'package:vasa/screens/tambah_rekening.dart';
import 'package:vasa/screens/transaksi.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BotNav extends StatefulWidget {
  const BotNav({super.key});

  @override
  BotNavState createState() => BotNavState();
}

class BotNavState extends State<BotNav> {
  DateTime _homePageDate = DateTime.now();

  final List<Widget> _children = [
    HomePage(initialDate: DateTime.now()),
    const GrafikScreen(),
    const Transaksi(),       // Transaksi screen
    const LaporanPage(),     // Laporan screen
    const ProfilePage(),
    const MengelolaRekening(),
    const TambahRekening(),
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
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Pengelola Keuangan', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else if (Globals.currentIndex == 1) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Grafik Keuangan', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else if (Globals.currentIndex == 2) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Tambah Transaksi', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else if (Globals.currentIndex == 3) {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: const Center(
          child: Text('Laporan Keuangan', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      );
    } else if (Globals.currentIndex == 4) {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: const Center(
          child: Text('More Feature', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: Colors.cyan,
        items: const [
          TabItem(icon: Icons.account_balance, title: 'Keuangan'),
          TabItem(icon: Icons.bar_chart, title: 'Chart'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.receipt_long, title: 'Report'),
          TabItem(icon: Icons.more_horiz, title: 'More'),
        ],
        initialActiveIndex: Globals.currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
