import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:vasa/models/database.dart';

class GrafikScreen extends StatefulWidget {
  const GrafikScreen({super.key});

  @override
  GrafikScreenState createState() => GrafikScreenState();
}

class GrafikScreenState extends State<GrafikScreen> {
  DateTime _selectedDate = DateTime.now();
  late Future<List<Pengelolaan>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<List<Pengelolaan>> _fetchData() async {
    final database = AppDatabase(NativeDatabase.memory());
    final startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final endDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    return await database.getPengelolaanByMonth(startDate, endDate);
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 5, 1),
      lastDate: DateTime(DateTime.now().year + 5, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dataFuture = _fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => _selectMonth(context),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.yMMM().format(_selectedDate),
            style: GoogleFonts.montserrat(),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Pengelolaan>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            } else {
              final data = snapshot.data ?? [];
              final totalAmount = data.fold(0, (sum, item) => sum + item.uang);

              // Group data by category and calculate percentages
              final Map<String, double> categoryPercentages = {};
              for (var item in data) {
                if (!categoryPercentages.containsKey(item.jenis)) {
                  categoryPercentages[item.jenis] = 0;
                }
                categoryPercentages[item.jenis] =
                    (categoryPercentages[item.jenis]! + item.uang);
              }

              categoryPercentages
                  .updateAll((key, value) => (value / totalAmount) * 100);

              return Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections:
                                    categoryPercentages.entries.map((entry) {
                                  return PieChartSectionData(
                                    color: _getColorForCategory(entry.key),
                                    value: entry.value.toDouble(),
                                    title: '${entry.value.toStringAsFixed(2).replaceAll('.00', '')}%',
                                    radius: 50,
                                    titleStyle: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: categoryPercentages.keys.map((category) {
                              final amount = categoryPercentages[category]!;
                              final icon = _getIconData(category);
                              final iconColor = _getColorForCategory(category);

                              return Column(
                                children: [
                                  _buildIncomeItem(
                                    icon,
                                    category,
                                    '${amount.toInt()}%',
                                    iconColor,
                                  ),
                                  const Divider(),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Belanja':
        return Colors.blue;
      case 'Makanan':
        return Colors.orange;
      case 'Pendidikan':
        return Colors.green;
      case 'Pulsa':
        return Colors.red;
      case 'Game':
        return Colors.purple;
      case 'Pakaian':
        return Colors.pink;
      case 'Transportasi':
        return Colors.yellow;
      case 'Minuman':
        return Colors.teal;
      case 'Rokok':
        return Colors.brown;
      case 'Elektronik':
        return Colors.grey;
      case 'Flight':
        return Colors.indigo;
      case 'Peliharaan':
        return Colors.lime;
      case 'Hadiah':
        return Colors.amber;
      case 'Donasi':
        return Colors.cyan;
      case 'Buah':
        return Colors.deepOrange;
      case 'Lain-lain':
        return Colors.blueGrey;
      case 'Gaji':
        return Colors.green;
      case 'Investasi':
        return Colors.blue;
      case 'Paruh Waktu':
        return Colors.orange;
      case 'Penghargaan':
        return Colors.purple;
      default:
        return Colors.black;
    }
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
}
