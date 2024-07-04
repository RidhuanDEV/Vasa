import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';
import 'package:vasa/models/database.dart';
import 'package:vasa/screens/tambah_rekening.dart';

class MengelolaRekening extends StatefulWidget {
  const MengelolaRekening({super.key});

  @override
  MengelolaRekeningState createState() => MengelolaRekeningState();
}

class MengelolaRekeningState extends State<MengelolaRekening> {
  
  late AppDatabase _database;
  late Future<List<Rekening>> _rekeningFuture;
    Future<List<Rekening>> _fetchAllRekenings() async {
    return await _database.getAllRekenings();
  }

  Future<void> _deleteRekening(int id) async {
    await _database.deleteRekening(id);
    setState(() {
      _rekeningFuture = _fetchAllRekenings();
    });
  }
  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index; // Mengatur nilai currentIndex dari global.dart
    });
  }

    IconData _getIconData(String jenis) {
    switch (jenis) {
      // Icons Rekening
      case 'crypto':
        return Icons.currency_bitcoin_sharp;
      case 'credit':
        return Icons.credit_card;
      case 'money':
        return Icons.attach_money;
      case 'wallet':
        return Icons.account_balance_wallet;
      case 'atm':
        return Icons.account_balance;
      default:
        return Icons.error;
    }
  }

  String _formatCurrency(int amount) {
    if (amount.abs() >= 1000000000000000) {
      return '${(amount.abs() / 1000000000000000).toStringAsFixed(1)} Kuadriliun';
    } else if (amount.abs() >= 1000000000000) {
      return '${(amount.abs() / 1000000000000).toStringAsFixed(1)} Trilyun';
    } else if (amount.abs() >= 1000000000) {
      return '${(amount.abs() / 1000000000).toStringAsFixed(1)} Milyar';
    } else if (amount.abs() >= 1000000) {
      return '${(amount.abs() / 1000000).toStringAsFixed(1)} Juta';
    } else if (amount.abs() >= 1000) {
      return '${(amount.abs() / 1000).toStringAsFixed(1)} ribu';
    } else {
      return amount.toString();
    }
  }
  @override
  void initState() {
    super.initState();
    _database = AppDatabase(NativeDatabase.memory());
    _rekeningFuture = _fetchAllRekenings();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: (Globals.currentIndex == 4)
        ? AppBar(
            title: const Text('Mengelola Rekening'),
            backgroundColor: Colors.cyan,
            toolbarHeight: 80,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () {
                onTabTapped(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
            ),
          )
        : null,
    body: Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Rekening>>(
            future: _rekeningFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Rekening found'));
              } else {
                return ListView(
                  children: snapshot.data!.map((rekening) {
                    return _buildRekeningItem(
                      _getIconData(rekening.jenis),
                      rekening.catatan,
                      rekening.uang < 0
                          ? _formatCurrency(rekening.uang.abs()).replaceAll('.0', '')
                          : _formatCurrency(rekening.uang).replaceAll('.0', ''),
                      rekening.uang < 0 ? Colors.red : Colors.blue,
                      rekening.id, // Pass the rekening ID
                      rekening, // Pass the rekening object
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              Globals.currentIndex = 5;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Tambahkan',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan, // Warna tombol
              minimumSize: const Size(double.infinity, 50), // Lebar penuh
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildRekeningItem(IconData icon, String title, String amount, Color iconColor, int id, Rekening rekening) {
    return Container(
      height: 600,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      
      ),
      child: SingleChildScrollView(
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(amount, style: GoogleFonts.montserrat(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahRekening(rekening: rekening),
                    ),
                  ).then((_) {
                    setState(() {
                      _rekeningFuture = _fetchAllRekenings();
                    });
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await _deleteRekening(id);
                },
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
