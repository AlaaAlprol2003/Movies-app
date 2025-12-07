import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/entities/user_profile_entity.dart';
import '../repo/profile_repo.dart';

@lazySingleton
class ProfileUseCase {
  ProfileRepo profileRepo;
  ProfileUseCase({required this.profileRepo});

  Future<Either<Failure, UserProfileEntity>> call() {
    return profileRepo.getProfile();
  }
}
