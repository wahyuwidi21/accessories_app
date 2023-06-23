import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/category_model.dart';
import 'package:accessories_app/data/repository/category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) => _mapFetchCategory(emit, event));
    on<AddCategory>((event, emit) => _mapAddCategory(emit, event));
    on<AddAllCategory>((event, emit) => _mapAddAllCategory(emit, event));
  }
  final CategoryRepository categoryRepository;

  Future<void> _mapFetchCategory(
      Emitter<CategoryState> emit, FetchCategory event) async {
    emit(CategoryLoading());
    try {
      emit(CategorySuccess(await categoryRepository.fetchAllCategories()));
    } on HttpException catch (e) {
      emit(CategoryFailed(e.message));
    } on Exception catch (e) {
      emit(CategoryFailed(e.toString()));
    }
  }

  Future<void> _mapAddCategory(
      Emitter<CategoryState> emit, AddCategory event) async {
    emit(CategoryLoading());
    try {
      await categoryRepository.addCategory(event.categoryModel);
      emit(AddCategorySuccess());
    } on Exception catch (e) {
      emit(AddCategoryFailed());
    }
  }

  Future<void> _mapAddAllCategory(
      Emitter<CategoryState> emit, AddAllCategory event) async {
    emit(CategoryLoading());
    List<CategoryModel> list = [
      CategoryModel(categoryId: 1, name: "Aksesoris", binary: [1, 0, 0]),
      CategoryModel(categoryId: 2, name: "Tas", binary: [0, 1, 0]),
      CategoryModel(categoryId: 3, name: "Lainnya", binary: [0, 0, 1])
    ];
    var categories = await categoryRepository.fetchAllCategories();
    if (categories.isNotEmpty) {
      emit(AddAllCategorySuccess());
    } else {
      try {
        await categoryRepository.addAllCategories(list);
        emit(AddAllCategorySuccess());
      } on Exception catch (e) {
        emit(AddAllCategoryFailed());
      }
    }
  }
}
