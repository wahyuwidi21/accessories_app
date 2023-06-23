import 'package:hive/hive.dart';
part 'cart_entity.g.dart';

@HiveType(typeId: 4)
class CartEntity extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  static String boxName = "cartBox";

  @HiveField(0)
  late int productId;

  @HiveField(1)
  late int quantity;

  @HiveField(2)
  late String email;

  CartEntity(this.productId, this.quantity, this.email);
}
