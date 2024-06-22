import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  AkunPageState createState() => AkunPageState();
}

class AkunPageState extends State<AkunPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String gender = 'Laki-Laki';
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize with default values or fetch from database/api
    idController.text = '1234456';
    nameController.text = 'Muhammad Fahreza';
    imagePath = 'assets/avatar.png'; // Default image path
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _saveChanges() {
    String id = idController.text;
    String name = nameController.text;

    // Print the updated values to the console
    print('Saved ID: $id');
    print('Saved Name: $name');
    print('Saved Gender: $gender');
    print('Saved Image Path: $imagePath');

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!))
                    : const AssetImage('assets/avatar.png') as ImageProvider,
                radius: 30,
              ),
              title: const Text('Foto'),
              trailing: const Icon(Icons.edit),
              onTap: _pickImage,
            ),
            const Divider(),
            ListTile(
              title: const Text('ID'),
              subtitle: TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Nama'),
              subtitle: TextField(
                controller: nameController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Jenis Kelamin'),
              subtitle: DropdownButton<String>(
                value: gender,
                onChanged: (String? newValue) {
                  setState(() {
                    gender = newValue!;
                  });
                },
                items: <String>['Laki-Laki', 'Perempuan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logic to log out
              },
              child: const Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
