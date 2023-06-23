import 'package:hive/hive.dart';
part 'transaction_entity.g.dart';

@HiveType(typeId: 5)
class TransactionEntity extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  static String boxName = "transactionBox";

  @HiveField(0)
  late String listCart;

  @HiveField(1)
  late String email;

  TransactionEntity(this.listCart, this.email);
}
