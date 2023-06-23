import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.profileRepository) : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) => _mapFetch(emit, event));
  }
  final AuthRepository profileRepository;

  Future<void> _mapFetch(
      Emitter<RegisterState> emit, RegisterUser event) async {
    emit(RegisterLoading());
    try {
      bool success = await profileRepository.register(event.profileModel);
      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailed("User sudah terdaftar"));
      }
    } on Exception catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
