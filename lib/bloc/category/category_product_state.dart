part of 'category_product_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);
}

class CategoryFailed extends CategoryState {
  final String message;

  CategoryFailed(this.message);
}

class AddCategorySuccess extends CategoryState {
  AddCategorySuccess();
}

class AddCategoryFailed extends CategoryState {
  AddCategoryFailed();
}

class AddAllCategorySuccess extends CategoryState {
  AddAllCategorySuccess();
}

class AddAllCategoryFailed extends CategoryState {
  AddAllCategoryFailed();
}
