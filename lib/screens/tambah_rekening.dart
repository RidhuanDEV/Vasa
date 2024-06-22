import 'package:flutter/material.dart';
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';

class TambahRekening extends StatefulWidget {
  const TambahRekening({super.key});

  @override
  State<TambahRekening> createState() => _TambahRekeningState();
}

class _TambahRekeningState extends State<TambahRekening> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaRekeningController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  bool isButtonEnabled = false;

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex =
          index; // Mengatur nilai currentIndex dari global.dart
    });
  }

  void checkFormStatus() {
    if (namaRekeningController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        catatanController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    namaRekeningController.addListener(checkFormStatus);
    jenisController.addListener(checkFormStatus);
    jumlahController.addListener(checkFormStatus);
    catatanController.addListener(checkFormStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Globals.currentIndex == 5)
          ? AppBar(
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                onPressed: () {
                  Globals.currentIndex = 4;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
              title: const Text('Tambahkan'),
              backgroundColor: Colors.cyan,
              toolbarHeight: 80,
              centerTitle: true,
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: namaRekeningController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Rekening',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi Nama Rekening';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: jenisController,
                  decoration: const InputDecoration(
                    labelText: 'Jenis',
                    border: OutlineInputBorder(),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi Jumlah';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: catatanController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi Catatan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.money,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              jenisController.text = 'money';
                            },
                          ),
                          const Text('money'),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.credit_card,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              jenisController.text = 'credit';
                            },
                          ),
                          const Text('credit'),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.attach_money,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              jenisController.text = 'money';
                            },
                          ),
                          const Text('money'),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.account_balance_wallet,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              jenisController.text = 'wallet';
                            },
                          ),
                          const Text('wallet'),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.account_balance,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              jenisController.text = 'atm';
                            },
                          ),
                          const Text('atm'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 84),
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            // Tambahkan rekening action
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.cyan,
                    textStyle: const TextStyle(fontSize: 20,),
                  ),
                  child: const  Text('Tambahkan Rekening', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
