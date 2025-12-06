import 'package:dartz/dartz.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/watch_list_repo.dart';

import '../../../../../../../../core/errors/errors/failure.dart';

class AddWatchListUseList {
  WatchListRepo watchListRepo;
  AddWatchListUseList({required this.watchListRepo});

  Future<Either<Failure, void>> call({required String movieId}) async {
    return await watchListRepo.addMovieToWatchList(movieId: movieId);
  }
}