import 'package:dartz/dartz.dart';

import '../../../../../../../../core/errors/errors/failure.dart';

abstract class WatchListRepo {
  Future<Either<Failure, void>> addMovieToWatchList({required String movieId,});

}