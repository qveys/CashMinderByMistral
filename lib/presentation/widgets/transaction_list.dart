import 'package:flutter/material.dart';
import '../../data/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.description),
          subtitle: Text('${transaction.date.toLocal()} • ${transaction.amount} €'),
          trailing: Text(transaction.category ?? 'Non classé'),
        );
      },
    );
  }
}