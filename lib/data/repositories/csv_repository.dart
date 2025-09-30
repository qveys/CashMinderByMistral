import 'dart:io';
import 'package:csv/csv.dart';
import '../models/transaction.dart';

class CsvRepository {
  Future<List<Transaction>> importTransactions(File file) async {
    final csvString = await file.readAsString();
    final csvData = const CsvToListConverter().convert(csvString, eol: "\n");

    // Ignorer la première ligne (en-tête)
    final transactions = <Transaction>[];
    for (var i = 1; i < csvData.length; i++) {
      final row = csvData[i];
      if (row.length >= 3) {
        transactions.add(
          Transaction(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            date: DateTime.parse(row[0]),
            amount: double.parse(row[1]),
            description: row[2],
          ),
        );
      }
    }
    return transactions;
  }
}