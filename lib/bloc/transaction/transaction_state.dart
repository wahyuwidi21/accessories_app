part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionSuccess(
    this.transactions,
  );
}

class TransactionFailed extends TransactionState {
  final String message;

  TransactionFailed(this.message);
}

class AddTransactionSuccess extends TransactionState {
  AddTransactionSuccess();
}

class AddTransactionFailed extends TransactionState {
  AddTransactionFailed();
}
