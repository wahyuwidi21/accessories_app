part of 'all_product_bloc.dart';

@immutable
abstract class AllProductEvent {}

class FetchAllProducts extends AllProductEvent {}

class AddProduct extends AllProductEvent {
  ProductModel productModel;
  AddProduct(this.productModel);
}

class AddAllProduct extends AllProductEvent {
  // List<ProductModel> allProductModel;
  AddAllProduct(
      // this.allProductModel
      );
}
