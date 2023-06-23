import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/cart_model.dart';
import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/model/transaction_model.dart';
import 'package:accessories_app/data/repository/cart_repository.dart';
import 'package:accessories_app/data/repository/transaction_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc(this.transactionRepository) : super(TransactionInitial()) {
    on<FetchTransaction>((event, emit) => _mapFetchTransaction(emit, event));
    on<AddTransaction>((event, emit) => _mapAddTransaction(emit, event));
  }
  final TransactionRepository transactionRepository;

  Future<void> _mapFetchTransaction(
      Emitter<TransactionState> emit, FetchTransaction event) async {
    emit(TransactionLoading());
    try {
      final value = await transactionRepository.fetchTransactions();
      emit(TransactionSuccess(value));
    } on HttpException catch (e) {
      emit(TransactionFailed(e.message));
    } on Exception catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  Future<void> _mapAddTransaction(
      Emitter<TransactionState> emit, AddTransaction event) async {
    try {
      await transactionRepository.addCartToTransaction(event.listCartModel);
      emit(AddTransactionSuccess());
    } on Exception catch (e) {
      emit(AddTransactionFailed());
    }
  }
}
