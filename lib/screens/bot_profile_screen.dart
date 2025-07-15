import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/bot.dart';

class BotProfileScreen extends StatefulWidget {
  const BotProfileScreen({super.key});

  @override
  State<BotProfileScreen> createState() => _BotProfileScreenState();
}

class _BotProfileScreenState extends State<BotProfileScreen> {
  final nameController = TextEditingController();
  final taglineController = TextEditingController();
  final descriptionController = TextEditingController();
  final greetingController = TextEditingController();

  String? _profilePicPath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePicPath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Bot')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _profilePicPath != null
                        ? FileImage(File(_profilePicPath!))
                        : null,
                child:
                    _profilePicPath == null
                        ? const Icon(Icons.add_a_photo, size: 30)
                        : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: taglineController,
              decoration: const InputDecoration(labelText: 'Tagline'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: greetingController,
              decoration: const InputDecoration(labelText: 'Greeting'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final bot = Bot(
                  name: nameController.text,
                  tagline: taglineController.text,
                  description: descriptionController.text,
                  greeting: greetingController.text,
                  profilePicPath: _profilePicPath,
                );
                Navigator.pop(context, bot);
              },
              child: const Text('Save Bot'),
            ),
          ],
        ),
      ),
    );
  }
}
