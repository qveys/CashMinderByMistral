import 'package:flutter/material.dart';
import 'import_screen.dart'; // Import du fichier séparé

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashMinder'),
      ),
      body: const Center(
        child: Text('Aperçu des dépenses récentes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ImportScreen()),
          );
        },
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}