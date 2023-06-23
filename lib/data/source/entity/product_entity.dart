import 'package:hive/hive.dart';
part 'product_entity.g.dart';

@HiveType(typeId: 2)
class ProductEntity extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  static String boxName = "productBox";

  @HiveField(0)
  late int productId;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String categoryId;
  @HiveField(3)
  late String category;
  @HiveField(4)
  late String categoryBinary;
  @HiveField(5)
  late String imageUrl;
  @HiveField(6)
  late int price;

  ProductEntity(this.productId, this.name, this.categoryId, this.category,
      this.categoryBinary, this.imageUrl, this.price);
}
