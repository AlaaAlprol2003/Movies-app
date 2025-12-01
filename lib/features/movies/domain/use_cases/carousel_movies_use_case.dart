import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/movie_summary_entity.dart';
import '../repos/movies_repo.dart';

@LazySingleton()
class CarouselMoviesUseCase {
  final MoviesRepo moviesRepo;
  CarouselMoviesUseCase({required this.moviesRepo});

  Future<Either<String, List<MovieSummaryEntity>>> call({int? limit}
      ) async {
    return await moviesRepo.getMovies(limit: limit);
  }
}