import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/transaction_list.dart';
import '../../bloc/transaction_bloc.dart';
import 'import_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashMinder'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            return TransactionList(transactions: state.transactions);
          } else if (state is TransactionError) {
            return Center(child: Text('Erreur : ${state.message}'));
          } else {
            return const Center(child: Text('Aucune transaction importée.'));
          }
        },
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