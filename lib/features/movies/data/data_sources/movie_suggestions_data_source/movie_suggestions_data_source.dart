import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import '../../models/movies/movie.dart';

abstract class MovieSuggestionsDataSource {
  Future<Either<Failure, List<Movie>>> getMovies({required int movieId});

}