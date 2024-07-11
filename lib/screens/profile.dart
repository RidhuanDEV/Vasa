import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasa/global.dart';
import 'package:vasa/screens/convert.dart';
import 'package:vasa/models/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late AppDatabase db;

  void onTabTapped(int index) {
    Globals.currentIndex = index;
  }

  Future<void> formatData() async {
    await db.deleteAllPengelola();
    await db.deleteAllRekenings();
  }

  @override
  void initState() {
    super.initState();
    db = AppDatabase(NativeDatabase.memory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.attach_money,
                text: 'Konversi Mata Uang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurrencyConversionPage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.privacy_tip,
                text: 'Kebijakan Privasi',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Kebijakan Privasi'),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pendahuluan\n'
                                'Selamat datang di aplikasi pencatatan keuangan kami. Kami berkomitmen untuk melindungi privasi Anda dan memastikan bahwa data pribadi Anda aman. Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi Anda.\n\n'
                                '1. Informasi yang Kami Kumpulkan\n'
                                'Kami dapat mengumpulkan dan memproses jenis informasi berikut:\n'
                                '- Informasi Pribadi: Nama, alamat email, nomor telepon.\n'
                                '- Informasi Keuangan: Data transaksi, saldo akun, dan catatan keuangan lainnya.\n'
                                '- Informasi Teknis: Alamat IP, jenis perangkat, dan data log lainnya.\n\n'
                                '2. Penggunaan Informasi\n'
                                'Kami menggunakan informasi yang kami kumpulkan untuk tujuan berikut:\n'
                                '- Layanan Inti: Memfasilitasi pencatatan dan manajemen keuangan Anda.\n'
                                '- Komunikasi: Mengirim pemberitahuan, pembaruan, dan informasi lainnya terkait dengan aplikasi.\n'
                                '- Keamanan: Memantau dan meningkatkan keamanan aplikasi kami.\n\n'
                                '3. Pembagian Informasi\n'
                                'Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga kecuali:\n'
                                '- Dengan Persetujuan Anda: Jika Anda memberikan persetujuan untuk berbagi informasi.\n'
                                '- Kewajiban Hukum: Jika diperlukan untuk memenuhi kewajiban hukum atau peraturan.\n\n'
                                '4. Keamanan Informasi\n'
                                'Kami mengimplementasikan langkah-langkah keamanan yang tepat untuk melindungi informasi pribadi Anda dari akses, pengungkapan, perubahan, atau penghancuran yang tidak sah.\n\n'
                                '5. Hak Pengguna\n'
                                'Anda memiliki hak untuk:\n'
                                '- Mengakses data pribadi Anda yang kami miliki.\n'
                                '- Meminta koreksi atau penghapusan data pribadi Anda.\n'
                                '- Menarik persetujuan Anda kapan saja.\n\n'
                                '6. Perubahan Kebijakan Privasi\n'
                                'Kami dapat memperbarui kebijakan privasi ini dari waktu ke waktu. Kami akan memberi tahu Anda tentang perubahan signifikan melalui aplikasi atau metode lainnya.\n\n'
                                '7. Kontak Kami\n'
                                'Jika Anda memiliki pertanyaan atau kekhawatiran tentang kebijakan privasi ini, Anda dapat menghubungi kami di:\n'
                                '- Email: support@financetrackerapp.com\n'
                                '- Telepon: +62 123 4567 890\n\n'
                                'Tanggal Berlaku: [Tanggal Berlaku]',
                              ),
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
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.info,
                text: 'Tentang Aplikasi',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Tentang Aplikasi'),
                        content: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                          'Tentang Aplikasi Pencatatan Uang \n\n'
                          'Aplikasi VASA adalah sebuah platform yang dirancang untuk membantu pengguna untuk melakukan pencatatan uang baik pengeluaran ataupun pemasukan guna membantu pengguna dalam memanajemen keuangannya.\n\n'
                          'Tujuan Pengembangan Aplikasi\n\n'
                          'Aplikasi ini dikembangkan sebagai bagian dari tugas mata kuliah Pemrograman Aplikasi Mobile. Tujuan utamanya adalah untuk mempraktikkan keterampilan pengembangan perangkat lunak, mulai dari perencanaan, desain, pengembangan, hingga pengujian dan peluncuran aplikasi. Proyek ini memberikan kesempatan bagi kami untuk mengaplikasikan teori dan konsep yang telah dipelajari selama perkuliahan dalam sebuah proyek nyata yang bermanfaat.\n\n'
                          'Dosen Pengampu: Muhamad Soleh, S.Si, M.Kom\n\n'
                          'Universitas: INSTITUT TEKNOLOGI INDONESIA\n\n'
                          'Proyek ini dibimbing oleh dosen pengampu kami, Muhamad Soleh, S.Si, M.Kom, yang telah memberikan arahan dan dukungan sepanjang proses pengembangan aplikasi.\n\n'
                          '\n\n'
                          'Aplikasi ini dikembangkan oleh kelompok kami yang terdiri dari:\n\n'
                          'RIDHUAN RANGGA KUSUMA - 1152200025 (Project Manager / Sub-programmer)\n'
                          'MUHAMMAD FAHREZA - 1152200006 (Data Analyst)\n'
                          'ANANDA PUTRA AHNAF - 1152200019 (Desainer)\n'
                          'LUTFI EKAPRIMA JANNATA - 1152200006 (Programmer)\n\n'
                          'RAYINDRA SATRYA FITRIAN - 1152200001 (Dokumenter)\n\n'
                          '\n\n'
                          'Kesimpulan\n\n'
                          'Kami berharap aplikasi ini tidak hanya memenuhi kebutuhan pengguna tentang menajemen kuangan para user, tetapi juga menjadi contoh nyata dari hasil belajar dan kerja keras kami selama mengikuti mata Pemrograman Aplikasi Mobile. Kami sangat menghargai dukungan dan bimbingan dari dosen pengampu serta kolaborasi yang solid dari seluruh anggota kelompok.',
                        ),
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
                },
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.delete,
                text: 'Hapus Data',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Hapus Data'),
                        content: const Text(
                            'Apakah Anda yakin ingin menghapus data penyimpanan anda ?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              formatData();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
