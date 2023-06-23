import 'dart:convert';

import 'package:accessories_app/data/model/category_model.dart';
import 'package:accessories_app/data/source/category_data_source.dart';

class CategoryRepository {
  CategoryRepository({required CategoryDataSource dataSource})
      : _dataSource = dataSource;

  final CategoryDataSource _dataSource;

  Future<void> addCategory(CategoryModel categoryModel) async {
    try {
      await _dataSource.addCategory(categoryModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addAllCategories(List<CategoryModel> listCategoryModel) async {
    try {
      await _dataSource.addAllCategories(listCategoryModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CategoryModel>> fetchAllCategories() async {
    final value = await _dataSource.fetchAllCategories();
    return value
        .map((e) => CategoryModel(
            categoryId: e.categoryId,
            name: e.name,
            binary: json.decode(e.binary).cast<int>()))
        .toList();
  }
}
