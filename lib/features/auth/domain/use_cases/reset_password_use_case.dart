import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/auth/data/models/Reset_password_request.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
@singleton
class ResetPasswordUseCase {
  AuthRepository authRepository;
  ResetPasswordUseCase({required this.authRepository});

  Future<Either<Failure, void>> call(ResetPasswordRequest request) {
    return authRepository.resetPassword(request);
  }
}
