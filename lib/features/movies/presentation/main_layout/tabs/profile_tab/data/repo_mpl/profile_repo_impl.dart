// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/edit_profile_response.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/entities/user_profile_entity.dart';
import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../domain/repo/profile_repo.dart';
import '../data_source/profile_data_source.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  ProfileDataSource profileDataSource;
  ProfileRepoImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile() async {
    try {
      AuthSharedPrefsLocalDataSource authLocalDataSource =
          AuthSharedPrefsLocalDataSource();
      String token = await authLocalDataSource.getToken();
      print(token);

      final response = await profileDataSource.getProfile(token);
      return Right(response.data.toUserProfileEntity());
    } on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, EditProfileResponse>> editProfile(
    String email,
    int avatarId,
    String name,
    String phone,
  ) async {
    try {
      AuthSharedPrefsLocalDataSource authLocalDataSource =
          AuthSharedPrefsLocalDataSource();
      String token = await authLocalDataSource.getToken();
      final response = await profileDataSource.editProfile(
        token,
        email,
        avatarId,
        name,
        phone,
      );
      return Right(response);
    } on AppExceptions catch (ex) {
      return Left(Failure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      AuthSharedPrefsLocalDataSource authLocalDataSource =
          AuthSharedPrefsLocalDataSource();
      String token = await authLocalDataSource.getToken();
      print(token);

      await profileDataSource.deleteProfile(token);
      return Right(null);
    } on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }
}
