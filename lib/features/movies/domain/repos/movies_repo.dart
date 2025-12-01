import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';

@singleton
abstract class MoviesRepo{
Future<Either<String, List<MovieSummaryEntity>>> getMovies({int? limit, String? genres,String? queryTerm});
}