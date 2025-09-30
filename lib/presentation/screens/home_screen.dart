import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/transaction_list.dart';
import '../widgets/pie_chart.dart';
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
            return Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Répartition des dépenses par catégorie :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                PieChartWidget(transactions: state.transactions),
                const SizedBox(height: 20),
                const Text(
                  'Liste des transactions :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TransactionList(transactions: state.transactions),
                ),
              ],
            );
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