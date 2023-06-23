part of 'recommended_product_bloc.dart';

@immutable
abstract class RecommendedProductState {}

class RecommendedProductInitial extends RecommendedProductState {}

class RecommendedProductLoading extends RecommendedProductState {}

class RecommendedProductSuccess extends RecommendedProductState {
  final List<ProductModel> products;

  RecommendedProductSuccess(this.products);
}

class RecommendedProductFailed extends RecommendedProductState {
  final String message;

  RecommendedProductFailed(this.message);
}
