import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/edit_profile_response.dart';
import '../../../../../../../../core/errors/errors/failure.dart';
import '../entities/user_profile_entity.dart';

@lazySingleton
abstract class ProfileRepo {
  Future<Either<Failure, UserProfileEntity>> getProfile();
  Future<Either<Failure, EditProfileResponse>> editProfile(
    String email,
    int avatarId,
    String name,

    String phone,
  );
}
