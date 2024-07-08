import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasa/global.dart';
import 'package:vasa/screens/convert.dart';
import 'package:vasa/models/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late AppDatabase db;

  void onTabTapped(int index) {
    Globals.currentIndex = index;
  }

  Future<void> formatData() async {
    await db.deleteAllPengelola();
    await db.deleteAllRekenings();
  }

  @override
  void initState() {
    super.initState();
    db = AppDatabase(NativeDatabase.memory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.attach_money,
                text: 'Konversi Mata Uang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurrencyConversionPage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.privacy_tip,
                text: 'Kebijakan Privasi',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Kebijakan Privasi'),
                        content:
                            const Text('Aplikasi ini dibuat oleh kelompok 1'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.info,
                text: 'Tentang Kami',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Tentang Kami'),
                        content:
                            const Text('Aplikasi ini dibuat oleh kelompok 1'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.delete,
                text: 'Hapus Data',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Hapus Data'),
                        content: const Text(
                            'Apakah Anda yakin ingin menghapus data penyimpanan anda ?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              formatData();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
