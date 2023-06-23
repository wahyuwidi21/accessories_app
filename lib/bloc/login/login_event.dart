part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AttemptLogin extends LoginEvent {
  String email;
  String password;
  AttemptLogin({required this.email, required this.password});
}
