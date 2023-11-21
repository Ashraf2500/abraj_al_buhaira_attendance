part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginData ;

  LoginSuccessState({required this.loginData});
}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}


