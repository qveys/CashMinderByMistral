import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class ClassificationRepository {
  static const String _apiUrl = 'https://api.example.com/classify'; // À remplacer par l'URL de votre API

  Future<List<Transaction>> classifyTransactions(List<Transaction> transactions) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'transactions': transactions.map((tx) => {
            'description': tx.description,
            'amount': tx.amount,
          }).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var i = 0; i < transactions.length; i++) {
          transactions[i].category = data['categories'][i];
        }
        return transactions;
      } else {
        throw Exception('Failed to classify transactions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error classifying transactions: $e');
    }
  }
}