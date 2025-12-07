import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/profile_repo.dart';
@lazySingleton
class DeleteProfileUseCase{
  ProfileRepo profileRepo;
  DeleteProfileUseCase({required this.profileRepo});

  Future<Either<Failure, void>> call() {
    return profileRepo.deleteProfile();
  }
}