import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaction.dart';

class LocalStorageRepository {
  static const String _transactionsKey = 'transactions';

  Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = transactions.map((tx) => tx.toJson()).toList();
    await prefs.setString(_transactionsKey, jsonEncode(transactionsJson));
  }

  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = prefs.getString(_transactionsKey);
    if (transactionsJson != null) {
      final List<dynamic> decoded = jsonDecode(transactionsJson);
      return decoded.map((json) => Transaction.fromJson(json)).toList();
    }
    return [];
  }
}

extension TransactionJson on Transaction {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'description': description,
      'category': category,
    };
  }

  static Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
      description: json['description'],
      category: json['category'],
    );
  }
}