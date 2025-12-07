import 'package:dartz/dartz.dart';

import '../../../../../../../../core/errors/errors/failure.dart';
import '../../../../../../domain/entities/movie_summary_entity.dart';
import '../../data/models/watch_list_request.dart';

abstract class WatchListRepo {
  Future<Either<Failure, void>> addMovieToWatchList({required WatchListRequest request,});
  Future<Either<Failure, List<MovieSummaryEntity>>> getWatchListMovies();
  Future<Either<Failure, void>> deleteMovieFromWatchList({required String movieId,});
  Future<Either<Failure, bool>> isAddedToWatchList({required String movieId,});

}