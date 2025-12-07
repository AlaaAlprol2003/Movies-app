import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../../../core/errors/errors/failure.dart';
import '../../domain/repos/movies_repo.dart';
import '../data_sources/movies_data_source/movies_data_source.dart';

@Singleton(as: MoviesRepo)
class MoviesRepoImpl implements MoviesRepo {
  MoviesRepoImpl({required this.dataSource});

  final MoviesDataSource dataSource;

  @override
  Future<Either<Failure, List<MovieSummaryEntity>>> getMovies({
    int? limit,
    String? genres,
    String? queryTerm,
  }) async {
    try {
      final result = await dataSource.getMovies(
        limit: limit,
        genres: genres,
        queryTerm: queryTerm,
      );
      return result.fold(
        (failure) => Left(failure),
        (movies) =>
            Right(movies.map((movie) => movie.toMovieSummaryEntity()).toList()),
      );
    } catch (e) {
      return Left(Failure(
          message: "Unexpected error occurred: ${e.toString()}"
      ));
    }
  }

}
