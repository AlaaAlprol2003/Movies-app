import 'package:dartz/dartz.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../domain/repos/movies_repo.dart';
import '../data_sources/movies_data_source.dart';

class MoviesRepoImpl implements MoviesRepo {
  MoviesRepoImpl({required this.dataSource});

  final MoviesDataSource dataSource;

  @override
  Future<Either<String, List<MovieSummaryEntity>>> getMovies({
    int? limit,
  }) async {
    try {
      final result = await dataSource.getMovies(
        limit: limit,
      );
      return result.fold(
        (failure) => Left(failure),
        (movies) => Right(
          movies
              .map(
                (movie) => MovieSummaryEntity(
                  id: movie.id,
                  rating: movie.rating,
                  genres: movie.genres,
                  mediumCoverImage: movie.mediumCoverImage,

                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
