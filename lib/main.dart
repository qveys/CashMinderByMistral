import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/home_screen.dart';
import 'bloc/transaction_bloc.dart';
import 'data/repositories/csv_repository.dart';
import 'data/repositories/classification_repository.dart';
import 'data/repositories/local_storage_repository.dart';

void main() {
  runApp(const CashMinderApp());
}

class CashMinderApp extends StatelessWidget {
  const CashMinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CsvRepository()),
        RepositoryProvider(create: (context) => ClassificationRepository()),
        RepositoryProvider(create: (context) => LocalStorageRepository()),
      ],
      child: BlocProvider(
        create: (context) => TransactionBloc(
          csvRepository: RepositoryProvider.of<CsvRepository>(context),
          classificationRepository: RepositoryProvider.of<ClassificationRepository>(context),
          localStorageRepository: RepositoryProvider.of<LocalStorageRepository>(context),
        )..add(LoadTransactions()),
        child: MaterialApp(
          title: 'CashMinder',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}