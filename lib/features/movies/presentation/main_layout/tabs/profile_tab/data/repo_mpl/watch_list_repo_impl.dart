import 'package:dartz/dartz.dart';

import 'package:movies_app/core/errors/errors/failure.dart';

import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import '../../domain/repo/watch_list_repo.dart';
import '../data_source/watch_list_data_source.dart';

class WatchListRepoImpl implements WatchListRepo{
  final WatchListDataSource watchListDataSource;
  WatchListRepoImpl({required this.watchListDataSource});
  @override
  Future<Either<Failure, void>> addMovieToWatchList({required String movieId})async {
   try {
    String token = await AuthSharedPrefsLocalDataSource().getToken();
    watchListDataSource.addMovieToWatchList(movieId: movieId, token: token);
    return const Right(null);
  }on AppExceptions catch (exception) {
     return Left(Failure(message: exception.message));
   }
  }

}