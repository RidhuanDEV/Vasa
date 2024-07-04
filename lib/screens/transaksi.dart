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

  Future<void> insert(String jenis, int jumlah, int type, String catatan, DateTime tanggal) async {
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
      dateController.text = DateFormat('yyyy-MM-dd').format(widget.transaction!.transaksidate);
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
        title: Text(isEditMode ? 'Edit Transaksi' : 'Tambahkan Transaksi'),
        backgroundColor: Colors.cyan,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  shape:  RoundedRectangleBorder(
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
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
                          labelText: 'Enter Date',
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
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            dateController.text = formattedDate;
                          }
                        },
                      ),
                      const SizedBox(height: 32),
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
                                    await updateTransaction(widget.transaction!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Update Berhasil'),
                                      ),
                                    );
                                  } else {
                                    await insert(
                                      jenisController.text,
                                      int.parse(jumlahController.text),
                                      type,
                                      catatanController.text,
                                      DateTime.parse(dateController.text),
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
                            isEditMode ? 'Save Changes' : 'Tambahkan Transaksi',
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
  final List<Map<String, dynamic>> pengeluaranIcons = [
    {'icon': Icons.shopping_cart, 'label': 'Belanja'},
    {'icon': Icons.restaurant, 'label': 'Makanan'},
    {'icon': Icons.school, 'label': 'Pendidikan'},
    {'icon': Icons.phone_android, 'label': 'Pulsa'},
    {'icon': Icons.videogame_asset, 'label': 'Game'},
    {'icon': Icons.checkroom, 'label': 'Pakaian'},
    {'icon': Icons.directions_bus, 'label': 'Transportasi'},
    {'icon': Icons.local_bar, 'label': 'Minuman'},
    {'icon': Icons.smoking_rooms, 'label': 'Rokok'},
    {'icon': Icons.electrical_services, 'label': 'Elektronik'},
    {'icon': Icons.flight, 'label': 'Flight'},
    {'icon': Icons.pets, 'label': 'Peliharaan'},
    {'icon': Icons.card_giftcard, 'label': 'Hadiah'},
    {'icon': Icons.volunteer_activism, 'label': 'Donasi'},
    {'icon': Icons.local_florist, 'label': 'Buah'},
    {'icon': Icons.apps, 'label': 'Lain-lain'},
  ];

  final List<Map<String, dynamic>> pemasukanIcons = [
    {'icon': Icons.attach_money, 'label': 'Gaji'},
    {'icon': Icons.trending_up, 'label': 'Investasi'},
    {'icon': Icons.work, 'label': 'Paruh Waktu'},
    {'icon': Icons.emoji_events, 'label': 'Penghargaan'},
    {'icon': Icons.apps, 'label': 'Lain-lain'},
  ];
}
