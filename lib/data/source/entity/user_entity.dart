import 'package:hive/hive.dart';
part 'user_entity.g.dart';

@HiveType(typeId: 1)
class UserEntity extends HiveObject {
  // @HiveField(0)
  // List simNumber;
  static String boxName = "userBox";

  @HiveField(0)
  String? email;

  @HiveField(1)
  String? password;

  @HiveField(2)
  String? nama;

  UserEntity(
    this.email,
    this.password,
    this.nama,
  );
}
