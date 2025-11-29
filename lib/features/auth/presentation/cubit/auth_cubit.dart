import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/auth/data/models/register_request.dart';
import 'package:movies_app/features/auth/domain/use_cases/register_use_case.dart';
@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.registerUseCase}) : super(AuthInitialState());
  RegisterUseCase registerUseCase;
  void register(RegisterRequest request) async {
    emit(RegisterLoading());
    final response = await registerUseCase(request);
    response.fold(
      (failure) {
        emit(RegisterError(message: failure.message));
      },
      (user) {
        emit(RegisterSuccess());
      },
    );
  }
}

class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  String message;
  RegisterError({required this.message});
}

class RegisterSuccess extends AuthState {
 
}
