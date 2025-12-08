import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/app_exceptions.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:movies_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movies_app/features/auth/data/models/Reset_password_request.dart';
import 'package:movies_app/features/auth/data/models/login_request.dart';
import 'package:movies_app/features/auth/data/models/register_request.dart';
import 'package:movies_app/features/auth/domain/entities/user_entity.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';

import '../data_sources/local/auth_shared_prefs_local_data_source.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> register(RegisterRequest request) async {
    try {
      final response = await authRemoteDataSource.register(request);
      await authLocalDataSource.saveToken(response.user.sId);
      return Right(response.user.toUserEntity());
    } on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, String>> login(LoginRequest request) async {
    try {
      final response = await authRemoteDataSource.login(request);
      await authLocalDataSource.saveToken(response.data);
      return Right(response.data);
    } on AppExceptions catch (exception) {
      return left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(ResetPasswordRequest request)async {
   try {
     AuthSharedPrefsLocalDataSource authLocalDataSource = AuthSharedPrefsLocalDataSource();
     String token = await authLocalDataSource.getToken();
   await  authRemoteDataSource.resetPassword(request, token);
     return Right(null);
   }catch (exception) {
     return Left(Failure(message: "Failed to reset password"));
   }
  }
}
