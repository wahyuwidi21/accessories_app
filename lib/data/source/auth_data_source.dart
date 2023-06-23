import 'dart:async';

import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/source/entity/user_entity.dart';
import 'package:hive/hive.dart';

class AuthDataSource {
  Box<UserEntity> userBox = Hive.box<UserEntity>('userBox');

  Future<bool> addUser(ProfileModel profileModel) async {
    try {
      Iterable userEntity = userBox.values;

      List<UserEntity> listUser = userEntity.toList() as List<UserEntity>;
      final user =
          listUser.where((element) => element.email == profileModel.email);
      if (user.isNotEmpty) {
        return false;
      }
      userBox.add(UserEntity(
          profileModel.email, profileModel.password, profileModel.fullname));
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserEntity> fetchMe(String email) async {
    try {
      Iterable userEntity =
          userBox.values.where((element) => element.email == email);
      return userEntity.toList()[0] as FutureOr<UserEntity>;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> login(String email, String password) async {
    try {
      Iterable userEntity =
          userBox.values.where((element) => element.email == email);

      List<UserEntity> listUser = userEntity.toList() as List<UserEntity>;
      if (listUser.isEmpty) {
        return "User tidak ditemukan";
      }

      if (listUser[0].password != password) {
        return "Password Salah";
      }

      return "Sukses";
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
