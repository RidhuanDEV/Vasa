import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:vasa/botnav.dart';
import 'package:vasa/global.dart';
import 'package:vasa/models/database.dart';

class TambahRekening extends StatefulWidget {
  final Rekening? rekening;

  const TambahRekening({super.key, this.rekening});

  @override
  State<TambahRekening> createState() => _TambahRekeningState();
}

class _TambahRekeningState extends State<TambahRekening> {
  final AppDatabase database = AppDatabase(NativeDatabase.memory());
  final _formKey = GlobalKey<FormState>();
  TextEditingController jenisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  bool isButtonEnabled = false;
  
  String? selectedIcon;

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index;
    });
  }

  void checkFormStatus() {
    if (jenisController.text.isNotEmpty &&
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

  Future<void> insert(String jenis, int jumlah, String catatan, String nama) async {
    await database.into(database.rekenings).insertReturning(
      RekeningsCompanion.insert(
        jenis: jenis,
        uang: jumlah,
        catatan: catatan,
        namaRekening: nama,
      ),
    );
  }

  Future<void> updateRekening(Rekening rekening) async {
    final updatedRekening = rekening.copyWith(
      jenis: jenisController.text,
      uang: int.parse(jumlahController.text),
      catatan: catatanController.text,
      namaRekening: namaController.text,
    );

    await database.updateRekening(updatedRekening);
  }

  @override
  void initState() {
    super.initState();
    jenisController.addListener(checkFormStatus);
    jumlahController.addListener(checkFormStatus);
    catatanController.addListener(checkFormStatus);
    namaController.addListener(checkFormStatus);

    if (widget.rekening != null) {
      namaController.text = widget.rekening!.namaRekening;
      jenisController.text = widget.rekening!.jenis;
      jumlahController.text = widget.rekening!.uang.toString();
      catatanController.text = widget.rekening!.catatan;
      selectedIcon = widget.rekening!.jenis;
    }
  }

  void setIconJenis(String jenis) {
    setState(() {
      jenisController.text = jenis;
      selectedIcon = jenis;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.rekening != null;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            Globals.currentIndex = 0;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BotNav()),
            );
          },
        ),
        title: Text(isEditMode ? 'Edit Rekening' : 'Tambahkan Rekening'),
        backgroundColor: Colors.cyan,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Rekening',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap isi Catatan';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: jumlahController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Uang',
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
                        controller: jenisController,
                        decoration: const InputDecoration(
                          labelText: 'Jenis',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
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
                      SizedBox(
                        height: 100,
                        child: GridView.count(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: rekeningIcons.map((icon) {
                                  return GestureDetector(
                                    onTap: () {
                                      setIconJenis(icon['label']);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          icon['icon'],
                                          color: selectedIcon == icon['label']
                                              ? Colors.green[500]
                                              : Colors.black,
                                          size: 30,
                                        ),
                                        Text(
                                          icon['label'],
                                          style: TextStyle(
                                            color: selectedIcon == icon['label']
                                                ? Colors.green[500]
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  if (isEditMode) {
                                    await updateRekening(widget.rekening!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Update Berhasil'),
                                      ),
                                    );
                                  } else {
                                    await insert(
                                      jenisController.text,
                                      int.parse(jumlahController.text),
                                      catatanController.text,
                                      namaController.text,
                                    );
                                  }
                                  Globals.currentIndex = 0;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BotNav(),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? Colors.blue
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            isEditMode ? 'Save Changes' : 'Tambahkan Rekening',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  final List<Map<String, dynamic>> rekeningIcons = [
    {'icon': Icons.currency_bitcoin_sharp, 'label': 'crypto'},
    {'icon': Icons.credit_card, 'label': 'credit'},
    {'icon': Icons.attach_money, 'label': 'money'},
    {'icon': Icons.account_balance_wallet, 'label': 'wallet'},
    {'icon': Icons.account_balance, 'label': 'atm'},
  ];
}
