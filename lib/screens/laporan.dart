import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // Add this import for DateFormat
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';
import 'package:vasa/models/database.dart'; // Add this import for database queries

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  LaporanPageState createState() => LaporanPageState();
}

class LaporanPageState extends State<LaporanPage> {
  bool isAnalysisSelected = true;
  DateTime selectedYear = DateTime.now();
  late AppDatabase db;
  int totalCrypto = 0;
  int totalCredit = 0;
  int totalMoney = 0;
  int totalWallet = 0;
  int totalAtm = 0;
  @override
  void initState() {
    super.initState();
    db = AppDatabase(NativeDatabase.memory());
  }

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index;
    });
  }

  void toggleSelection() {
    setState(() {
      isAnalysisSelected = !isAnalysisSelected;
    });
  }

  Future<Map<String, dynamic>> fetchAnalysisData(int year) async {
    int pemasukan = await db.getTotalByTypeAndYear(2, year);
    int pengeluaran = await db.getTotalByTypeAndYear(1, year);
    int totalAnggaranBulanan = pemasukan - pengeluaran;

    double total = pemasukan.toDouble() + pengeluaran.toDouble();
    double pengeluaranPercentage = (pengeluaran / total) * 100;
    double pemasukanPercentage = (pemasukan / total) * 100;

    return {
      'pemasukan': pemasukan,
      'pengeluaran': pengeluaran,
      'totalAnggaranBulanan': totalAnggaranBulanan,
      'pengeluaranPercentage': pengeluaranPercentage,
      'pemasukanPercentage': pemasukanPercentage,
    };
  }

  Future<Map<String, int>> fetchMonthlyData(int year, int month) async {
    int pemasukan = await db.getTotalByTypeAndMonth(2, year, month);
    int pengeluaran = await db.getTotalByTypeAndMonth(1, year, month);
    return {
      'pemasukan': pemasukan,
      'pengeluaran': pengeluaran,
    };
  }

  Future<void> selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.cyan,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              titleMedium: TextStyle(color: Colors.black),
            ),
            colorScheme: const ColorScheme.light(primary: Colors.cyan),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedYear) {
      setState(() {
        selectedYear = picked;
      });
    }
  }

  Future<List<Rekening>> _fetchRekenings(String jenis) {
    return db.getRekeningByjenis(jenis);
  }

  Future<void> _calculateTotals() async {
    int total1 = await db.getTotalRekening('crypto');
    int total2 = await db.getTotalRekening('credit');
    int total3 = await db.getTotalRekening('money');
    int total4 = await db.getTotalRekening('wallet');
    int total5 = await db.getTotalRekening('atm');
    setState(() {
      totalCrypto = total1;
      totalCredit = total2;
      totalMoney = total3;
      totalWallet = total4;
      totalAtm = total5;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Globals.currentIndex == 2)
          ? AppBar(
              title: const Text('Laporan'),
              centerTitle: true,
              backgroundColor: Colors.cyan,
            )
          : null,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAnalysisSelected = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isAnalysisSelected ? Colors.black : Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Analisis',
                  style: GoogleFonts.montserrat(
                    color: isAnalysisSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAnalysisSelected = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isAnalysisSelected ? Colors.white : Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Rekening',
                  style: GoogleFonts.montserrat(
                    color: isAnalysisSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          isAnalysisSelected
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.grey[200],
                  ),
                  child: ElevatedButton(
                    onPressed: () => selectYear(context),
                    child: Text(
                        'Pilih Tahun: ${DateFormat.y().format(selectedYear)}'),
                  ),
                )
              : Container(),
          Expanded(
            child: isAnalysisSelected
                ? buildAnalysisSection()
                : buildAccountSection(),
          ),
        ],
      ),
    );
  }

  String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }

  Widget buildAnalysisSection() {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchAnalysisData(selectedYear.year),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        final pemasukan = data['pemasukan'] as int;
        final pengeluaran = data['pengeluaran'] as int;
        final totalAnggaranBulanan = data['totalAnggaranBulanan'] as int;
        final pengeluaranPercentage = data['pengeluaranPercentage'] as double;
        final pemasukanPercentage = data['pemasukanPercentage'] as double;

        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Anggaran Bulanan Tahun ${selectedYear.year}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                width: double.infinity,
                height: 280,
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final month =
                        DateFormat.MMM().format(DateTime(0, index + 1));
                    return FutureBuilder<Map<String, int>>(
                      future: fetchMonthlyData(selectedYear.year, index + 1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No data available'));
                        }

                        final monthlyData = snapshot.data!;
                        final monthlyPengeluaran = monthlyData['pengeluaran']!;
                        final monthlyPemasukan = monthlyData['pemasukan']!;
                        final monthlyBalance =
                            monthlyPemasukan - monthlyPengeluaran;

                        return buildMonthlyStatistic(
                          month,
                          monthlyPengeluaran,
                          monthlyPemasukan,
                          monthlyBalance,
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Anggaran Tahunan',
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 120,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.orange,
                              value: pengeluaranPercentage,
                              title: formatPercentage(pengeluaranPercentage)
                                  .replaceAll('.0', ''),
                              radius: 50,
                              titleStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.lightGreen,
                              value: pemasukanPercentage,
                              title: formatPercentage(pemasukanPercentage)
                                  .replaceAll('.0', ''),
                              radius: 50,
                              titleStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.lightGreen,
                            ),
                            const SizedBox(width: 8,),                  
                            Text(
                              'Pemasukan: ${_formatCurrency(pemasukan).replaceAll('.0', '')}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(                      
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              'Pengeluaran: ${_formatCurrency(pengeluaran).replaceAll('.0', '')}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Saldo Anggaran Tahunan',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _formatCurrency(totalAnggaranBulanan)
                            .replaceAll('.0', ''),
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: totalAnggaranBulanan >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMonthlyStatistic(
      String month, int pengeluaran, int pemasukan, int balance) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              month,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengeluaran: ${_formatCurrency(pengeluaran).replaceAll('.0', '')}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Pemasukan: ${_formatCurrency(pemasukan).replaceAll('.0', '')}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Saldo: ${_formatCurrency(balance).replaceAll('.0', '')}',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: balance >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountSection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black)),
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Crypto',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatCurrency(totalCrypto).replaceAll('.0', ''),
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Rekening>>(
                      future: _fetchRekenings('crypto'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Rekening'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((rekening) {
                              return _buildExpenseItem(
                                  rekening.namaRekening,
                                  _getIconData(rekening.jenis),
                                  rekening.catatan,
                                  _formatCurrency(rekening.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black)),
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Credit',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatCurrency(totalCrypto).replaceAll('.0', ''),
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Rekening>>(
                      future: _fetchRekenings('credit'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Rekening'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((rekening) {
                              return _buildExpenseItem(
                                  rekening.namaRekening,
                                  _getIconData(rekening.jenis),
                                  rekening.catatan,
                                  _formatCurrency(rekening.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black)),
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Money',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatCurrency(totalCrypto).replaceAll('.0', ''),
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Rekening>>(
                      future: _fetchRekenings('money'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Rekening'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((rekening) {
                              return _buildExpenseItem(
                                  rekening.namaRekening,
                                  _getIconData(rekening.jenis),
                                  rekening.catatan,
                                  _formatCurrency(rekening.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black)),
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wallet',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatCurrency(totalCrypto).replaceAll('.0', ''),
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Rekening>>(
                      future: _fetchRekenings('wallet'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Rekening'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((rekening) {
                              return _buildExpenseItem(
                                  rekening.namaRekening,
                                  _getIconData(rekening.jenis),
                                  rekening.catatan,
                                  _formatCurrency(rekening.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.black)),
                      
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ATM',
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatCurrency(totalCrypto).replaceAll('.0', ''),
                          style: GoogleFonts.montserrat(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 160,
                    child: FutureBuilder<List<Rekening>>(
                      future: _fetchRekenings('atm'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Tidak ada Data Rekening'));
                        } else {
                          return ListView(
                            children: snapshot.data!.map((rekening) {
                              return _buildExpenseItem(
                                  rekening.namaRekening,
                                  _getIconData(rekening.jenis),
                                  rekening.catatan,
                                  _formatCurrency(rekening.uang)
                                      .replaceAll('.0', ''),
                                  Colors.red);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Globals.currentIndex = 4;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Mengelola Rekening',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
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

  Widget _buildExpenseItem(String nama, IconData icon, String title,
      String amount, Color iconColor) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(nama),
        subtitle: Text(title),
        trailing: Text(amount, style: GoogleFonts.montserrat(fontSize: 16)),
      ),
    );
  }
}
