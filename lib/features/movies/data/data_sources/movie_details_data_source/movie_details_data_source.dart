import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/movies/data/models/movie_details/detailed_movie.dart';


abstract class MovieDetailsDataSource {
  Future<Either<Failure,DetailedMovie>> getMovies({required int movieId});

}