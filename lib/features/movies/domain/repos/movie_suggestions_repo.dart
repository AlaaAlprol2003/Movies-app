import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';


abstract class MovieSuggestionsRepo{
  Future<Either<Failure, List<MovieSummaryEntity>>> getMovies({required int movieId});
}