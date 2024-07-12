import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vasa/botnav.dart';
import 'package:vasa/global.dart';
import 'package:vasa/models/database.dart';

class Transaksi extends StatefulWidget {
  final Pengelolaan? transaction;

  const Transaksi({super.key, this.transaction});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final AppDatabase database = AppDatabase(NativeDatabase.memory());
  final _formKey = GlobalKey<FormState>();
  TextEditingController jenisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int type = 1;
  bool isButtonEnabled = false;
  bool isPengeluaran = true;
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

  Future<void> insert(String jenis, int jumlah, int type, String catatan,
      DateTime tanggal) async {
    DateTime now = DateTime.now();
    await database.into(database.pengelola).insertReturning(
          PengelolaCompanion.insert(
            jenis: jenis,
            uang: jumlah,
            catatan: catatan,
            createdAt: now,
            updatedAt: now,
            type: type,
            transaksidate: tanggal,
          ),
        );
  }

  Future<void> updateTransaction(Pengelolaan transaction) async {
    DateTime now = DateTime.now();
    final updatedTransaction = transaction.copyWith(
      jenis: jenisController.text,
      uang: int.parse(jumlahController.text),
      catatan: catatanController.text,
      type: type,
      transaksidate: DateTime.parse(dateController.text),
      updatedAt: now,
    );

    await database.updateTransaction(updatedTransaction);
  }

  @override
  void initState() {
    super.initState();
    jenisController.addListener(checkFormStatus);
    jumlahController.addListener(checkFormStatus);
    catatanController.addListener(checkFormStatus);

    if (widget.transaction != null) {
      jenisController.text = widget.transaction!.jenis;
      jumlahController.text = widget.transaction!.uang.toString();
      catatanController.text = widget.transaction!.catatan;
      dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.transaction!.transaksidate);
      type = widget.transaction!.type;
      isPengeluaran = type == 1;
      selectedIcon = widget.transaction!.jenis;
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
    final isEditMode = widget.transaction != null;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(isEditMode ? 'Edit Transaksi' : 'Buat Transaksi Baru'),
        backgroundColor: Colors.cyan,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Add space above the buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPengeluaran = true;
                    type = 1;
                    selectedIcon = null;
                    jenisController.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPengeluaran ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: !isPengeluaran ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Pengeluaran',
                  style: TextStyle(
                    color: !isPengeluaran ? Colors.black : Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8), // Add space between the buttons
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPengeluaran = false;
                    type = 2;
                    jenisController.clear();
                    selectedIcon = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isPengeluaran ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: isPengeluaran ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Pemasukan',
                  style: TextStyle(
                    color: isPengeluaran ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Add space below the buttons
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: isPengeluaran
                            ? pengeluaranIcons.map((icon) {
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
                                      const SizedBox(
                                          height:
                                              8), // Add space between icon and label
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
                              }).toList()
                            : pemasukanIcons.map((icon) {
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
                                      const SizedBox(
                                          height:
                                              8), // Add space between icon and label
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
                    const SizedBox(height: 16), // Add space below the icons
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: dateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan Tanggal',
                              border: OutlineInputBorder(),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 5),
                                lastDate: DateTime(DateTime.now().year + 5),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                dateController.text = formattedDate;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      final jenis = jenisController.text;
                                      final jumlah =
                                          int.parse(jumlahController.text);
                                      final catatan = catatanController.text;
                                      final tanggal =
                                          DateTime.parse(dateController.text);

                                      if (isEditMode) {
                                        await updateTransaction(
                                          widget.transaction!.copyWith(
                                            jenis: jenis,
                                            uang: jumlah,
                                            catatan: catatan,
                                            type: type,
                                            transaksidate: tanggal,
                                          ),
                                        );
                                        
                                      } else {
                                        await insert(jenis, jumlah, type,
                                            catatan, tanggal);
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BotNav()),
                                      );
                                      if (!isEditMode){
                                        showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Konfirmasi'),
                                          content: const SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Transaksi berhasil ditambahkan!'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Tutup'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                      }else {
                                      ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Update Berhasil'),
                                          ),
                                        );
                                    }
                                    }
                                    
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isButtonEnabled ? Colors.green : Colors.grey,
                            ),
                            child: const Text('Tambahkan Transaksi'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> pengeluaranIcons = [
  {'icon': Icons.shopping_cart, 'label': 'Belanja'},
  {'icon': Icons.restaurant, 'label': 'Makanan'},
  {'icon': Icons.school, 'label': 'Pendidikan'},
  {'icon': Icons.phone_android, 'label': 'Pulsa'},
  {'icon': Icons.videogame_asset, 'label': 'Game'},
  {'icon': Icons.checkroom, 'label': 'Pakaian'},
  {'icon': Icons.directions_car, 'label': 'Transportasi'},
  {'icon': Icons.local_drink, 'label': 'Minuman'},
  {'icon': Icons.smoking_rooms, 'label': 'Rokok'},
  {'icon': Icons.pets, 'label': 'Hewan Peliharaan'},
  {'icon': Icons.park, 'label': 'Hobi'},
  {'icon': Icons.medical_services, 'label': 'Kesehatan'},
];

final List<Map<String, dynamic>> pemasukanIcons = [
  {'icon': Icons.attach_money, 'label': 'Gaji'},
  {'icon': Icons.money, 'label': 'Bonus'},
  {'icon': Icons.business_center, 'label': 'Bisnis'},
  {'icon': Icons.card_giftcard, 'label': 'Hadiah'},
  {'icon': Icons.savings, 'label': 'Investasi'},
  {'icon': Icons.real_estate_agent, 'label': 'Properti'},
  {'icon': Icons.people, 'label': 'Freelance'},
  {'icon': Icons.support, 'label': 'Dukungan'},
];
