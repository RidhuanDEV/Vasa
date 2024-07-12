import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drift/native.dart';
import 'package:intl/intl.dart';
import 'package:vasa/models/database.dart';
import 'package:vasa/screens/viewtransaksi.dart';

class HomePage extends StatefulWidget {
  final DateTime? initialDate;

  const HomePage({super.key, this.initialDate});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late AppDatabase _database;
  DateTime _selectedDate =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  int _totalExpense = 0;
  int _totalIncome = 0;
  @override
  void initState() {
    _database = AppDatabase(NativeDatabase.memory());
    _calculateTotals();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateTotals();
      });
    }
  }

  Future<void> _calculateTotals() async {
    if (_selectedDate == DateTime.now()) {
      int totalExpense =
          await _database.getTotalByTypeAndDate(1, DateTime.now());
      int totalIncome =
          await _database.getTotalByTypeAndDate(2, DateTime.now());
      setState(() {
        _totalExpense = totalExpense;
        _totalIncome = totalIncome;
      });
    } else {
      int totalExpense =
          await _database.getTotalByTypeAndDate(1, _selectedDate);
      int totalIncome = await _database.getTotalByTypeAndDate(2, _selectedDate);
      setState(() {
        _totalExpense = totalExpense;
        _totalIncome = totalIncome;
      });
    }
  }

  Future<List<Pengelolaan>> _fetchTransactions(int type) {
    if (_selectedDate == DateTime.now()) {
      return _database.getTransactionsByTypeAndDate(type, DateTime.now());
    } else {
      return _database.getTransactionsByTypeAndDate(type, _selectedDate);
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

  IconData _getIconData(String jenis) {
    switch (jenis) {
      // Pengeluaran Icons
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
      case 'Hobi':
        return Icons.park;
      case 'Kesehatan':
        return Icons.medical_services;

      // Pemasukan Icons
      case 'Gaji':
        return Icons.attach_money;
      case 'Investasi':
        return Icons.trending_up;
      case 'Paruh Waktu':
        return Icons.work;
      case 'Penghargaan':
        return Icons.emoji_events;
      case 'Bonus':
        return Icons.money;
      case 'Bisnis':
        return Icons.business_center;
      case 'Properti':
        return Icons.real_estate_agent;
      case 'Freelance':
        return Icons.people;
      case 'Dukungan':
        return Icons.support;
      default:
        return Icons.error; // Default icon if nameicon is not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.cyan,
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Pengeluaran',
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatCurrency(_totalExpense).replaceAll('.0', ''),
                        style: GoogleFonts.montserrat(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Pemasukan',
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatCurrency(_totalIncome).replaceAll('.0', ''),
                        style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 0, 255, 8), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Saldo',
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (_totalIncome - _totalExpense < 0
                            ? '-${_formatCurrency(_totalIncome - _totalExpense).replaceAll('.0', '')}'
                            : _formatCurrency(_totalIncome - _totalExpense).replaceAll('.0', '')),
                        style: GoogleFonts.montserrat(
                            color: _totalIncome - _totalExpense < 0
                                ? Colors.red
                                : const Color.fromARGB(255, 0, 255, 8),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengeluaran',
                    style: GoogleFonts.montserrat(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Pengelolaan>>(
                      future: _fetchTransactions(1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Transaksi'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((transaction) {
                              return _buildExpenseItem(
                                  _getIconData(transaction.jenis),
                                  transaction.catatan,
                                  _formatCurrency(transaction.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Pemasukan',
                    style: GoogleFonts.montserrat(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Pengelolaan>>(
                      future: _fetchTransactions(2),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Transaksi'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((transaction) {
                              return _buildIncomeItem(
                                  _getIconData(transaction.jenis),
                                  transaction.catatan,
                                  _formatCurrency(transaction.uang)
                                      .replaceAll('.0', ''),
                                  Colors.blue);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 96.0, vertical: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewTransaksi()),
                        );
                      },
                      child: Center(
                        child: Text(
                          'View All',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(
      IconData icon, String title, String amount, Color iconColor) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        trailing: Text(amount, style: GoogleFonts.montserrat(fontSize: 16)),
      ),
    );
  }

  Widget _buildIncomeItem(
      IconData icon, String title, String amount, Color iconColor) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        trailing: Text(amount, style: GoogleFonts.montserrat(fontSize: 16)),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'Mei';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Agu';
      case 9:
        return 'Sep';
      case 10:
        return 'Okt';
      case 11:
        return 'Nov';
      case 12:
        return 'Des';
      default:
        return 'Unknown';
    }
  }
}
