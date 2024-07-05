import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasa/global.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  void onTabTapped(int index) {
    Globals.currentIndex = index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Globals.currentIndex == 3) ? PreferredSize(
        preferredSize:
            const Size.fromHeight(100.0), // Set the height of the AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.cyan, // Background color
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ridhuan Rangga',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'ID: 1152200025',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ) : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildProfileButton(
                context,
                icon: Icons.thumb_up,
                text: 'Rekomendasi ke teman',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.attach_money,
                text: 'Konversi Mata Uang',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.palette,
                text: 'Tema Aplikasi',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.privacy_tip,
                text: 'Kebijakan Privasi',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.info,
                text: 'Tentang Kami',
                onPressed: () {},
              ),
             
              const SizedBox(height: 10),
              buildProfileButton(
                context,
                icon: Icons.delete,
                text: 'Hapus Data',
                onPressed: () {},
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
