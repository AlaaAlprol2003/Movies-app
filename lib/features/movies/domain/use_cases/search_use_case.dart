import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/repos/movies_repo.dart';
@lazySingleton
class SearchUseCase {
  MoviesRepo moviesRepo;
  SearchUseCase({required this.moviesRepo});

  Future<Either<String, List<MovieSummaryEntity>>> call({
    String? queryTerm,
  }) async {
    return await moviesRepo.getMovies(queryTerm: queryTerm);
  }
}
