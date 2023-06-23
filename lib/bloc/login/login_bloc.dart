import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.profileRepository) : super(LoginInitial()) {
    on<AttemptLogin>((event, emit) => _mapFetch(emit, event));
  }
  final AuthRepository profileRepository;

  Future<void> _mapFetch(Emitter<LoginState> emit, AttemptLogin event) async {
    emit(LoginLoading());
    try {
      String message =
          await profileRepository.login(event.email, event.password);
      if (message != "Sukses") {
        emit(LoginFailed(message));
      } else {
        emit(LoginSuccess());
      }
    } on Exception catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
