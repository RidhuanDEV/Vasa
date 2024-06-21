import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '70.000',
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Pemasukan',
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0',
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Saldo',
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '100.000',
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                    style: GoogleFonts.montserrat(fontSize: 16.0,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Pengeluaran: 70.000',
                        style: GoogleFonts.montserrat(fontSize: 16.0,),
                      ),
                      Text(
                        'Pemasukan: 0',
                        style: GoogleFonts.montserrat(fontSize: 16.0,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
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
                      top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
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
        return '';
    }
  }
}
