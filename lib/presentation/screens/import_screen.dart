import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../data/repositories/csv_repository.dart';
import '../../data/repositories/classification_repository.dart';
import '../../data/repositories/local_storage_repository.dart';
import '../../data/models/transaction.dart';
import '../widgets/transaction_list.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final CsvRepository _csvRepository = CsvRepository();
  final ClassificationRepository _classificationRepository = ClassificationRepository();
  final LocalStorageRepository _localStorageRepository = LocalStorageRepository();

  List<Transaction> _transactions = [];
  bool _isLoading = false;

  Future<void> _importFile() async {
    setState(() => _isLoading = true);
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
      if (result != null) {
        final file = File(result.files.single.path!);
        final transactions = await _csvRepository.importTransactions(file);
        final classifiedTransactions = await _classificationRepository.classifyTransactions(transactions);
        await _localStorageRepository.saveTransactions(classifiedTransactions);
        setState(() => _transactions = classifiedTransactions);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Importer un relevé')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ElevatedButton(
                  onPressed: _importFile,
                  child: const Text('Sélectionner un fichier CSV'),
                ),
                const SizedBox(height: 20),
                if (_transactions.isNotEmpty)
                  Expanded(
                    child: TransactionList(transactions: _transactions),
                  ),
              ],
            ),
    );
  }
}