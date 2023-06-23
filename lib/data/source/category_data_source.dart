import 'dart:async';
import 'dart:convert';

import 'package:accessories_app/data/model/category_model.dart';
import 'package:accessories_app/data/source/entity/category_entity.dart';
import 'package:accessories_app/data/source/entity/user_entity.dart';
import 'package:hive/hive.dart';

class CategoryDataSource {
  Box<CategoryEntity> categoryBox = Hive.box<CategoryEntity>('categoryBox');

  Future<void> addCategory(CategoryModel categoryModel) async {
    try {
      categoryBox.add(CategoryEntity(categoryModel.categoryId,
          categoryModel.name, jsonEncode(categoryModel.binary)));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addAllCategories(List<CategoryModel> listCategoryModel) async {
    try {
      final categoryEntities = listCategoryModel
          .map((productModel) => CategoryEntity(productModel.categoryId,
              productModel.name, jsonEncode(productModel.binary)))
          .toList();
      categoryBox.addAll(categoryEntities);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryEntity>> fetchAllCategories() async {
    try {
      Iterable categories = categoryBox.values;
      return categories.toList() as FutureOr<List<CategoryEntity>>;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
