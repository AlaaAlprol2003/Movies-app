import 'package:dartz/dartz.dart';

import '../../../../../../../../core/errors/errors/failure.dart';
import '../../../../../../domain/entities/movie_summary_entity.dart';

abstract class WatchListRepo {
  Future<Either<Failure, void>> addMovieToWatchList({required String movieId,});
  Future<Either<Failure, List<MovieSummaryEntity>>> getWatchListMovies();

}