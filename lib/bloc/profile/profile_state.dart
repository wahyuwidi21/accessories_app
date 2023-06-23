part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel response;

  ProfileSuccess(this.response);
}

class ProfileFailed extends ProfileState {
  final String message;

  ProfileFailed(this.message);
}
