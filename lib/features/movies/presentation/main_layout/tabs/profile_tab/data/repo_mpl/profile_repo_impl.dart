import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/entities/user_profile_entity.dart';
import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../domain/repo/profile_repo.dart';
import '../data_source/profile_data_source.dart';
@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo{

  ProfileDataSource profileDataSource;
  ProfileRepoImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile() async{
    try {
      AuthSharedPrefsLocalDataSource authLocalDataSource = AuthSharedPrefsLocalDataSource();
      String token = await authLocalDataSource.getToken();
      print(token);

      final response = await profileDataSource.getProfile(token);
      return Right(response.data.toUserProfileEntity());
    } on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }


}