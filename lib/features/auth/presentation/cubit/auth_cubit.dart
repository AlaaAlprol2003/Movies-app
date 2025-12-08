import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/auth/data/models/login_request.dart';
import 'package:movies_app/features/auth/data/models/register_request.dart';
import 'package:movies_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:movies_app/features/auth/domain/use_cases/register_use_case.dart';

import 'auth_cubit_states.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.registerUseCase, required this.loginUseCase})
    : super(AuthInitialState());
  LoginUseCase loginUseCase;
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

  void login(LoginRequest request) async {
    emit(LoginLoading());
    final response = await loginUseCase(request);
    response.fold((failure){
      emit(LoginError(message: failure.message));
    }, (token){
      emit(LoginSuccess());
    });
  }
}
