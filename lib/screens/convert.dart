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

  final Map<String, String> _currencyNames = {
    'USD': 'Dollar',
    'EUR': 'Euro',
    'JPY': 'Yen',
    'GBP': 'Pound',
    'AUD': 'Australian Dollar',
    'CAD': 'Canadian Dollar',
    'CHF': 'Swiss Franc',
    'CNY': 'Yuan',
    'HKD': 'Hong Kong Dollar',
    'SGD': 'Singapore Dollar',
    'NZD': 'New Zealand Dollar',
    'THB': 'Baht',
    'MXN': 'Peso',
    'MYR': 'Ringgit',
    'KRW': 'Won',
    'INR': 'Rupee',
    'BRL': 'Real',
    'ZAR': 'Rand',
    'TRY': 'Lira',
    'IDR': 'Rupiah',
  };

  final List<String> _currencies = [
    'USD', 'EUR', 'JPY', 'GBP', 'AUD', 'CAD', 'CHF', 'CNY', 'HKD', 'SGD', 'NZD', 'THB', 'MXN', 'MYR', 'KRW', 'INR', 'BRL', 'ZAR', 'TRY', 'IDR'
  ];

  Future<void> _convertCurrency() async {
    final url = Uri.parse('https://v6.exchangerate-api.com/v6/fbf9de967294c12629b0d7c9/pair/$_fromCurrency/$_toCurrency/$_amount');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final conversionResult = data['conversion_result'];

      setState(() {
        _result = '$conversionResult $_toCurrency';
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
        title: const Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _fromCurrency,
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(_currencyNames[currency] ?? currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Dari'),
                  isExpanded: false,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _toCurrency,
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(_currencyNames[currency] ?? currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Ke'),
                  isExpanded: false,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _amount = double.tryParse(value) ?? 1.0;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: const Text('Konversi'),
              ),
              const SizedBox(height: 20),
              Text(
                _result,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
