abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  String message;
  RegisterError({required this.message});
}

class RegisterSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginError extends AuthState {
  String message;
  LoginError({required this.message});
}

class LoginSuccess extends AuthState {}
