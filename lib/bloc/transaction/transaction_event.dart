part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class FetchTransaction extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  List<CartModel> listCartModel;
  AddTransaction(this.listCartModel);
}
