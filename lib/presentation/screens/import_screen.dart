import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../bloc/transaction_bloc.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importer un relevé'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
            if (result != null) {
              final filePath = result.files.single.path!;
              context.read<TransactionBloc>().add(ImportTransactions(filePath));
              Navigator.pop(context); // Retour à l'écran d'accueil après import
            }
          },
          child: const Text('Sélectionner un fichier CSV'),
        ),
      ),
    );
  }
}