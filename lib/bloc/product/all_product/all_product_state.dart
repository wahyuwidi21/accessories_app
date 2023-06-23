part of 'all_product_bloc.dart';

@immutable
abstract class AllProductState {}

class AllProductInitial extends AllProductState {}

class AllProductLoading extends AllProductState {}

class AllProductSuccess extends AllProductState {
  final List<ProductModel> products;

  AllProductSuccess(this.products);
}

class AllProductFailed extends AllProductState {
  final String message;

  AllProductFailed(this.message);
}

class AddProductSuccess extends AllProductState {
  AddProductSuccess();
}

class AddProductFailed extends AllProductState {
  AddProductFailed();
}

class AddAllProductSuccess extends AllProductState {
  AddAllProductSuccess();
}

class AddAllProductFailed extends AllProductState {
  AddAllProductFailed();
}
