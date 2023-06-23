part of 'category_product_bloc.dart';

@immutable
abstract class CategoryEvent {}

class FetchCategory extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  CategoryModel categoryModel;
  AddCategory(this.categoryModel);
}

class AddAllCategory extends CategoryEvent {
  // List<CategoryModel> allCategoryModel;
  AddAllCategory(
      // this.allCategoryModel
      );
}
