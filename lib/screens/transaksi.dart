import 'package:flutter/material.dart';
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}
  
class _TransaksiState extends State<Transaksi> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController jenisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  bool isButtonEnabled = false;
  bool isPengeluaran = true;  
  String? selectedIcon;  // Menyimpan ikon yang dipilih

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index; // Mengatur nilai currentIndex dari global.dart
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

  @override
  void initState() {
    super.initState();
    jenisController.addListener(checkFormStatus);
    jumlahController.addListener(checkFormStatus);
    catatanController.addListener(checkFormStatus);
  }

  void setIconJenis(String jenis) {
    setState(() {
      jenisController.text = jenis;
      selectedIcon = jenis;  // Mengatur ikon yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            Globals.currentIndex = 0;
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
                    selectedIcon = null;  // Reset pilihan ikon
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPengeluaran = false;
                    selectedIcon = null;  // Reset pilihan ikon
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
                      const SizedBox(height: 32),
                      // tambahkan icon disini
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
                                          color: selectedIcon == icon['label'] ? Colors.green[500] : Colors.black,size: 30,
                                        ),
                                        Text(
                                          icon['label'],
                                          style: TextStyle(
                                            color: selectedIcon == icon['label'] ? Colors.green[500] : Colors.black,
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
                                          color : selectedIcon == icon['label'] ? Colors.green[500] : Colors.black,size: 30,
                                        ),
                                        Text(
                                          icon['label'],
                                          style: TextStyle(
                                            color: selectedIcon == icon['label'] ? Colors.green[500] : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                      const SizedBox(height: 1),
                      ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  Globals.currentIndex = 0;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainScreen(),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.cyan,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        child: const Text(
                          'Tambahkan Transaksi',
                          style: TextStyle(color: Colors.black),
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
