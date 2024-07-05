import 'package:flutter/material.dart';
import 'package:vasa/botnav.dart';
import 'package:vasa/global.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Globals.currentIndex == 7)
          ? AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              backgroundColor: Colors.cyan,
              title: const Text(
                'Pengaturan',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      body: ListView(
        children: [
          _buildListTile(Icons.account_circle, 'Akun', context, 0),
          _buildListTile(Icons.attach_money, 'Konversi Mata Uang', context, 1),
          _buildListTile(Icons.palette, 'Tema', context, 2),
          _buildListTile(Icons.privacy_tip, 'Kebijakan Privasi', context, 3),
          _buildListTile(Icons.info, 'Tentang kami', context, 4),
          _buildListTile(Icons.feedback, 'Umpan Balik', context, 5),
          _buildListTile(Icons.delete, 'Hapus Data', context, 6),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Warna garis bawah
            width: 0.5, // Ketebalan garis bawah
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          onTapTapped(context, index);
        },
      ),
    );
  }

  void onTapTapped(BuildContext context, int index) {
    
    switch (index) {
      case 0:
        Globals.currentIndex = 8;
        break;
      case 1:
        // page = const KonversiMataUangPage();
        break;
      case 2:
        // page = const TemaPage();
        break;
      case 3:
        // page = const KebijakanPrivasiPage();
        break;
      case 4:
        // page = const TentangKamiPage();
        break;
      case 5:
        // page = const UmpanBalikPage();
        break;
      case 6:
        // page = const HapusDataPage();
        break;
      default:
        return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BotNav()),
    );
  }
}