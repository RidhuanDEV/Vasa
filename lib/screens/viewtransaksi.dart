import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drift/native.dart';
import 'package:vasa/models/database.dart';
import 'package:vasa/screens/transaksi.dart';

class ViewTransaksi extends StatefulWidget {
  const ViewTransaksi({super.key});

  @override
  ViewTransaksiState createState() => ViewTransaksiState();
}

class ViewTransaksiState extends State<ViewTransaksi> {
  late AppDatabase _database;
  late Future<List<Pengelolaan>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase(NativeDatabase.memory());
    _transactionsFuture = _fetchAllTransactions();
  }

  Future<List<Pengelolaan>> _fetchAllTransactions() async {
    return await _database.getAllTransactions();
  }

  Future<void> _deleteTransaction(int id) async {
    await _database.deleteTransaction(id);
    setState(() {
      _transactionsFuture = _fetchAllTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions', style: GoogleFonts.montserrat()),
      ),
      body: FutureBuilder<List<Pengelolaan>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No transactions found'));
          } else {
            return ListView(
              children: snapshot.data!.map((transaction) {
                return _buildTransactionItem(
                  _getIconData(transaction.jenis),
                  transaction.catatan,
                  transaction.uang < 0 ? _formatCurrency(transaction.uang.abs()).replaceAll('.0', '') : _formatCurrency(transaction.uang).replaceAll('.0', ''),
                  transaction.uang < 0 ? Colors.red : Colors.blue,
                  transaction.id, // Pass the transaction ID
                  transaction, // Pass the transaction object
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  IconData _getIconData(String jenis) {
    switch (jenis) {
      case 'Belanja':
        return Icons.shopping_cart;
      case 'Makanan':
        return Icons.restaurant;
      case 'Pendidikan':
        return Icons.school;
      case 'Pulsa':
        return Icons.phone_android;
      case 'Game':
        return Icons.videogame_asset;
      case 'Pakaian':
        return Icons.checkroom;
      case 'Transportasi':
        return Icons.directions_bus;
      case 'Minuman':
        return Icons.local_bar;
      case 'Rokok':
        return Icons.smoking_rooms;
      case 'Elektronik':
        return Icons.electrical_services;
      case 'Flight':
        return Icons.flight;
      case 'Peliharaan':
        return Icons.pets;
      case 'Hadiah':
        return Icons.card_giftcard;
      case 'Donasi':
        return Icons.volunteer_activism;
      case 'Buah':
        return Icons.local_florist;
      case 'Lain-lain':
        return Icons.apps;
      case 'Gaji':
        return Icons.attach_money;
      case 'Investasi':
        return Icons.trending_up;
      case 'Paruh Waktu':
        return Icons.work;
      case 'Penghargaan':
        return Icons.emoji_events;
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

  Widget _buildTransactionItem(IconData icon, String title, String amount, Color iconColor, int id, Pengelolaan transaction) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
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
                    builder: (context) => Transaksi(transaction: transaction),
                  ),
                ).then((_) {
                  // Refresh the transaction list after returning from the edit screen
                  setState(() {
                    _transactionsFuture = _fetchAllTransactions();
                  });
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await _deleteTransaction(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
