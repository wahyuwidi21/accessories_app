import 'dart:async';
import 'dart:io';

import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) => _mapFetch(emit, event));
  }
  final AuthRepository profileRepository;

  Future<void> _mapFetch(Emitter<ProfileState> emit, FetchProfile event) async {
    emit(ProfileLoading());
    try {
      emit(ProfileSuccess(await profileRepository.fetchMe()));
    } on HttpException catch (e) {
      emit(ProfileFailed(e.message));
    } on Exception catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }
}
