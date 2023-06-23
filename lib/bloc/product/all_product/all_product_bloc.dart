import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/product_model.dart';
import 'package:accessories_app/data/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  AllProductBloc(this.productRepository) : super(AllProductInitial()) {
    on<FetchAllProducts>(
        (event, emit) => _mapFetchRecommendedProduct(emit, event));
    on<AddProduct>((event, emit) => _mapAddRecommendedProduct(emit, event));
    on<AddAllProduct>(
        (event, emit) => _mapAddAllRecommendedProduct(emit, event));
  }
  final ProductRepository productRepository;

  Future<void> _mapFetchRecommendedProduct(
      Emitter<AllProductState> emit, FetchAllProducts event) async {
    emit(AllProductLoading());
    try {
      emit(AllProductSuccess(await productRepository.fetchAllProducts()));
    } on HttpException catch (e) {
      emit(AllProductFailed(e.message));
    } on Exception catch (e) {
      emit(AllProductFailed(e.toString()));
    }
  }

  Future<void> _mapAddRecommendedProduct(
      Emitter<AllProductState> emit, AddProduct event) async {
    emit(AllProductLoading());
    try {
      await productRepository.addProduct(event.productModel);
      emit(AddProductSuccess());
    } on Exception catch (e) {
      emit(AddProductFailed());
    }
  }

  Future<void> _mapAddAllRecommendedProduct(
      Emitter<AllProductState> emit, AddAllProduct event) async {
    emit(AllProductLoading());
    List<ProductModel> list = [
      ProductModel(
          productId: 1,
          name: "Gelang Aceh",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 50000,
          imageUrl: "assets/images/img_product_1.png"),
      ProductModel(
          productId: 2,
          name: "Gelang Medan",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 100000,
          imageUrl: "assets/images/img_product_2.png"),
      ProductModel(
          productId: 3,
          name: "Gelang Padang",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 10000,
          imageUrl: "assets/images/img_product_3.png"),
      ProductModel(
          productId: 4,
          name: "Gelang Palembang",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 10000,
          imageUrl: "assets/images/img_product_4.png"),
      ProductModel(
          productId: 5,
          name: "Gelang Bengkulu",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 20000,
          imageUrl: "assets/images/img_product_5.png"),
      ProductModel(
          productId: 6,
          name: "Gelang Pangkal Pinang",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 10000,
          imageUrl: "assets/images/img_product_6.png"),
      ProductModel(
          productId: 7,
          name: "Gelang Batam",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 5000,
          imageUrl: "assets/images/img_product_7.png"),
      ProductModel(
          productId: 8,
          name: "Sekan Coklat Tua Hitam",
          categoryId: "1",
          category: "Aksesoris",
          categoryBinary: [1, 0, 0],
          price: 15000,
          imageUrl: "assets/images/img_product_8.png"),
      ProductModel(
          productId: 9,
          name: "Tas Noken",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 80000,
          imageUrl: "assets/images/img_product_9.png"),
      ProductModel(
          productId: 10,
          name: "Tas Jambi",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 80000,
          imageUrl: "assets/images/img_product_10.png"),
      ProductModel(
          productId: 11,
          name: "Tas Bandar Lampung",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 80000,
          imageUrl: "assets/images/img_product_11.png"),
      ProductModel(
          productId: 12,
          name: "Tas Serang",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 40000,
          imageUrl: "assets/images/img_product_12.png"),
      ProductModel(
          productId: 13,
          name: "Tas Jakarta",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 250000,
          imageUrl: "assets/images/img_product_13.png"),
      ProductModel(
          productId: 14,
          name: "Tas Bandung",
          categoryId: "2",
          category: "Tas",
          categoryBinary: [0, 1, 0],
          price: 300000,
          imageUrl: "assets/images/img_product_14.png"),
      ProductModel(
          productId: 15,
          name: "Sirih Kampur Pinang",
          categoryId: "3",
          category: "Lainnya",
          categoryBinary: [0, 0, 1],
          price: 10000,
          imageUrl: "assets/images/img_product_15.png"),
      ProductModel(
          productId: 16,
          name: "Buah Sirih",
          categoryId: "3",
          category: "Lainnya",
          categoryBinary: [0, 0, 1],
          price: 15000,
          imageUrl: "assets/images/img_product_16.png"),
      ProductModel(
          productId: 17,
          name: "Kalung Taring Babi",
          categoryId: "3",
          category: "Lainnya",
          categoryBinary: [0, 0, 1],
          price: 30000,
          imageUrl: "assets/images/img_product_17.png"),
    ];
    var products = await productRepository.fetchAllProducts();
    if (products.isNotEmpty) {
      emit(AddAllProductSuccess());
    } else {
      try {
        await productRepository.addAllProduct(list);
        emit(AddAllProductSuccess());
      } on Exception catch (e) {
        emit(AddAllProductFailed());
      }
    }
  }
}
