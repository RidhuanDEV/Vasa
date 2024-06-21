import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
// Library untuk menampilkan tanggal

class GrafikScreen extends StatefulWidget {
  const GrafikScreen({super.key});

  @override
  GrafikScreenState createState() => GrafikScreenState();
}

class GrafikScreenState extends State<GrafikScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildMonthButton('Mar 2024'),
                _buildMonthButton('Apr 2024'),
                _buildMonthButton('Bulan lalu'),
                _buildMonthButton('Bulan ini'),
              ],
            ),
          ),
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
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 71.42,
                            title: '71,42%',
                            radius: 50,
                            titleStyle: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.orange,
                            value: 28.57,
                            title: '28,57%',
                            radius: 50,
                            titleStyle: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Indicator(color: Colors.blue, text: 'Belanja', isSquare: false),
                      SizedBox(width: 10),
                      Indicator(color: Colors.orange, text: 'Makanan', isSquare: false),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Belanja',
                          style: GoogleFonts.montserrat(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '50.000',
                          style: GoogleFonts.montserrat(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Makanan',
                          style: GoogleFonts.montserrat(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '20.000',
                          style: GoogleFonts.montserrat(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthButton(String text) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          // Aksi untuk tombol Bulan
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side: BorderSide.none,
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
    );
  }
   
 
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = true,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        )
      ],
    );
  }
}
