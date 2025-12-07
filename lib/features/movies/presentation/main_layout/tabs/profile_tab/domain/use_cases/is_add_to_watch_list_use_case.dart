import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/watch_list_repo.dart';

import '../../../../../../../../core/errors/errors/failure.dart';

@lazySingleton
class IsAddToWatchListUseCase {
  WatchListRepo watchListRepo;
  IsAddToWatchListUseCase({required this.watchListRepo});

  Future<Either<Failure, bool>> call({required String movieId}) async {
    return await watchListRepo.isAddedToWatchList(movieId: movieId);
  }
}