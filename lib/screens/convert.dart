import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({super.key});

  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final _formKey = GlobalKey<FormState>();
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';
  double _amount = 1.0;
  String _result = '';

  final List<String> _currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'IDR',
    // Add more currencies as needed
  ];

  Future<void> _convertCurrency() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/$_fromCurrency');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data['rates'][_toCurrency];
      final result = _amount * rate;

      setState(() {
        _result = '$result $_toCurrency';
      });
    } else {
      setState(() {
        _result = 'Error fetching conversion rate';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _fromCurrency,
                items: _currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _fromCurrency = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Dari'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _toCurrency,
                items: _currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _toCurrency = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Ke'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _amount = double.tryParse(value) ?? 1.0;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: Text('Konversi'),
              ),
              const SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
