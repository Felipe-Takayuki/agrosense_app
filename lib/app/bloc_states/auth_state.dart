import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginState {
  final AuthResponse auth;
  LoginState({required this.auth});
}

class LoginInitial extends LoginState {
  LoginInitial() : super(auth: AuthResponse());
}

class LoginLoading extends LoginState {
  LoginLoading() : super(auth: AuthResponse());
}

class LoginConfirmed extends LoginState {
  LoginConfirmed({required AuthResponse logado}) : super(auth: logado);
}

class LoginError extends LoginState {
  final Exception exception;
  LoginError({required this.exception}) : super(auth: AuthResponse());
}

//--------------------------------------------------------------------------------------------------


