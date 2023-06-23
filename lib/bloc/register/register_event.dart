part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  ProfileModel profileModel;
  RegisterUser({required this.profileModel});
}
