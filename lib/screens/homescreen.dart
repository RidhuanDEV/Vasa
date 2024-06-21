import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengelola Keuangan',
          style: GoogleFonts.lato(), // Menggunakan Google Fonts
        ),
        backgroundColor: Colors.cyan[200],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.cyan[200],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Pengeluaran',
                      style: GoogleFonts.lato(color: Colors.white), // Menggunakan Google Fonts
                    ),
                    Text(
                      '70.000',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Pemasukan',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Saldo',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                    Text(
                      '100.000',
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '19 Jun Rabu',
                  style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Pengeluaran: 70.000',
                      style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Pemasukan: 0',
                      style: GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.fastfood, color: Colors.red),
                    title: Text('Abis Makan-makan cuy'),
                    trailing: Text('-20.000'),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.green),
                    title: Text('Abis Belanja cuy'),
                    trailing: Text('-50.000'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan aksi ketika tombol ditekan
        },
        backgroundColor: Colors.cyan[200],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.cyan[200],
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.note, color: Colors.white,size: 40),
              onPressed: () {
                // Tambahkan aksi ketika tombol ditekan
              },
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart, color: Colors.white,size: 40),
              onPressed: () {
                // Tambahkan aksi ketika tombol ditekan
              },
            ),
            const SizedBox(width: 40), // Tempat untuk floating action button
            IconButton(
              icon: const Icon(Icons.report, color: Colors.white,size: 40),
              onPressed: () {
                // Tambahkan aksi ketika tombol ditekan
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white,size: 40),
              onPressed: () {
                // Tambahkan aksi ketika tombol ditekan
              },
            ),
          ],
        ),
      ),
    );
  }
}