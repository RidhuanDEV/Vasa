import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this dependency for the pie chart
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  LaporanPageState createState() => LaporanPageState();
}

class LaporanPageState extends State<LaporanPage> {
  bool isAnalysisSelected = true;

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex =
          index; // Mengatur nilai currentIndex dari global.dart
    });
  }

  void toggleSelection() {
    setState(() {
      isAnalysisSelected = !isAnalysisSelected;
    });
  }

  String formatNumber(int number) {
    String sign = number < 0 ? '-' : '';
    number = number.abs();

    if (number >= 1000000000000) {
      return '$sign${(number / 1000000000000).toStringAsFixed(1)}T';
    } else if (number >= 1000000000) {
      return '$sign${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '$sign${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '$sign${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return '$sign$number';
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
                onPressed: (){
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
    int pemasukan = 1000000000000; // Example income
    int pengeluaran = 70000000000000; // Example expense
    int totalAnggaranBulanan = pemasukan - pengeluaran;

    double total = pemasukan.toDouble() + pengeluaran.toDouble();
    double pengeluaranPercentage = (pengeluaran / total) * 100;
    double pemasukanPercentage = (pemasukan / total) * 100;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            height: 280,
            child: ListView(
              children: [
                buildMonthlyStatistic(
                    'Jun', pengeluaran, pemasukan, totalAnggaranBulanan),
                buildMonthlyStatistic(
                    'Jul', pengeluaran, pemasukan, totalAnggaranBulanan),
                buildMonthlyStatistic(
                    'Aug', pengeluaran, pemasukan, totalAnggaranBulanan),
                buildMonthlyStatistic(
                    'Sep', pengeluaran, pemasukan, totalAnggaranBulanan),
                // Add more statistics here
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anggaran Bulanan',
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
                          title: formatPercentage(pengeluaranPercentage),
                          radius: 50,
                          titleStyle: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 14),
                        ),
                        PieChartSectionData(
                          color: Colors.blue,
                          value: pemasukanPercentage,
                          title: formatPercentage(pemasukanPercentage),
                          radius: 50,
                          titleStyle: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add some space
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pemasukan:',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatNumber(pemasukan),
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pengeluaran:',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatNumber(pengeluaran),
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Anggaran Bulanan:',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatNumber(totalAnggaranBulanan),
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMonthlyStatistic(
      String month, int expense, int income, int balance) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            month,
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pengeluaran',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              Text(
                formatNumber(expense),
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pemasukan',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              Text(
                formatNumber(income),
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              Text(
                formatNumber(balance),
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAccountSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.cyan[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kekayaan bersih',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '80.000',
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aset',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '80.000',
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Uang Tunai',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                trailing: Text(
                  '80.000',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.account_balance_wallet,
                    color: Colors.yellow[800]),
                title: Text(
                  'Reza',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                subtitle: Text(
                  'Rekening Sekarang',
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
                trailing: Text(
                  '80.000',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 44.0),
          child: ElevatedButton(
            onPressed: () {
              Globals.currentIndex = 4;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
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
      ],
    );
  }
}