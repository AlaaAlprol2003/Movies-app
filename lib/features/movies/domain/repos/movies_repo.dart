import 'package:dartz/dartz.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../../../core/errors/errors/failure.dart';


abstract class MoviesRepo{
Future<Either<Failure, List<MovieSummaryEntity>>> getMovies({int? limit, String? genres,String? queryTerm});
}