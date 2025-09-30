import 'package:flutter/material.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des transactions'),
      ),
      body: const Center(
        child: Text('Liste des transactions classées'),
      ),
    );
  }
}