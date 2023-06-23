import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:accessories_app/domain/recommended_products_domain.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recommended_product_event.dart';
part 'recommended_product_state.dart';

class RecommendedProductBloc
    extends Bloc<RecommendedProductEvent, RecommendedProductState> {
  RecommendedProductBloc(this.productRepository, this.recommendedProductsDomain)
      : super(RecommendedProductInitial()) {
    on<FetchRecommendedProducts>(
        (event, emit) => _mapFetchRecommendedProduct(emit, event));
  }
  final ProductRepository productRepository;
  final RecommendedProductsDomain recommendedProductsDomain;

  Future<void> _mapFetchRecommendedProduct(
      Emitter<RecommendedProductState> emit,
      FetchRecommendedProducts event) async {
    emit(RecommendedProductLoading());
    try {
      final value = await recommendedProductsDomain.getRecommendedProducts();
      if (value.isEmpty) {
        emit(RecommendedProductFailed("Belum ada rekomendasi untukmu"));
      } else {
        emit(RecommendedProductSuccess(value));
      }
    } on HttpException catch (e) {
      emit(RecommendedProductFailed(e.message));
    } on Exception catch (e) {
      emit(RecommendedProductFailed(e.toString()));
    }
  }
}
