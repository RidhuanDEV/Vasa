import 'package:flutter/material.dart';
import 'package:vasa/global.dart';
import 'package:vasa/main.dart';

class MengelolaRekening extends StatefulWidget {
  const MengelolaRekening({super.key});

  @override
  MengelolaRekeningState createState() => MengelolaRekeningState();
}

class MengelolaRekeningState extends State<MengelolaRekening> {
  
  final List<Map<String, String>> rekeningList = [
    {'name': 'Reza', 'type': 'Rekening Sekarang'},
    // Tambahkan lebih banyak data dari database di sini
  ];

  void onTabTapped(int index) {
    setState(() {
      Globals.currentIndex = index; // Mengatur nilai currentIndex dari global.dart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: (Globals.currentIndex == 4)
          ? AppBar(
              
              title: const Text('Mengelola Rekening'),
              backgroundColor: Colors.cyan,
              toolbarHeight: 80,
              centerTitle: true,
        
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                onPressed: () {
                  onTabTapped(2);
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()));
                },
              ),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 600,
              child: ListView.builder(
                itemCount: rekeningList.length,
                itemBuilder: (context, index) {
                  final rekening = rekeningList[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar2.png'), // Ganti dengan path ikon yang sesuai
                          ),
                        ),
                        title: Text(rekening['name']!, style: const TextStyle(fontSize: 20)),
                        subtitle: Text(rekening['type']!, style: const TextStyle(fontSize: 16)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Tambahkan logika untuk mengedit
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Tambahkan logika untuk menghapus
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1), // Menambahkan underline
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Tambahkan logika untuk menambah rekening baru
              },
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text(
                'Tambahkan',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan, // Warna tombol
                minimumSize: const Size(double.infinity, 50), // Lebar penuh
              ),
            ),
          ),
        ],
      ),
    );
  }
}
