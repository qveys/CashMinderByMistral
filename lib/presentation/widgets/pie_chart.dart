import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../data/models/transaction.dart';

class PieChartWidget extends StatelessWidget {
  final List<Transaction> transactions;

  const PieChartWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Regrouper les transactions par catégorie
    final Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      if (transaction.category != null) {
        final category = transaction.category!;
        categoryTotals[category] = (categoryTotals[category] ?? 0) + transaction.amount;
      }
    }

    // Convertir en données pour le graphique
    final data = categoryTotals.entries.map((entry) {
      return charts.Series<
          String,
          double
      >(
        id: 'Categories',
        domainFn: (category, _) => category,
        measureFn: (_, amount) => amount,
        data: [entry],
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: charts.PieChart(
        data,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 60,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto,
            ),
          ],
        ),
        behaviors: [
          charts.DatumLegend(
            position: charts.BehaviorPosition.bottom,
            horizontalFirst: false,
            desiredMaxRows: 2,
            cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
          ),
        ],
      ),
    );
  }
}