import 'package:hive/hive.dart';
part 'category_entity.g.dart';

@HiveType(typeId: 3)
class CategoryEntity extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  static String boxName = "categoryBox";

  @HiveField(0)
  late int categoryId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String binary;

  CategoryEntity(this.categoryId, this.name, this.binary);
}
