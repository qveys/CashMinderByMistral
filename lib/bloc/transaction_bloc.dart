import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/transaction.dart';
import '../data/repositories/csv_repository.dart';
import '../data/repositories/classification_repository.dart';
import '../data/repositories/local_storage_repository.dart';

// Événements
abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class ImportTransactions extends TransactionEvent {
  final String filePath;
  ImportTransactions(this.filePath);
}

// États
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
}

// Bloc
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CsvRepository csvRepository;
  final ClassificationRepository classificationRepository;
  final LocalStorageRepository localStorageRepository;

  TransactionBloc({
    required this.csvRepository,
    required this.classificationRepository,
    required this.localStorageRepository,
  }) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<ImportTransactions>(_onImportTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await localStorageRepository.getTransactions();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onImportTransactions(
    ImportTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final file = File(event.filePath);
      final transactions = await csvRepository.importTransactions(file);
      final classifiedTransactions = await classificationRepository.classifyTransactions(transactions);
      await localStorageRepository.saveTransactions(classifiedTransactions);
      emit(TransactionLoaded(classifiedTransactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}