import 'package:dartz/dartz.dart';
import '../entities/movie_summary_entity.dart';
import '../repos/movies_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabCategoriseUseCase {
  final MoviesRepo moviesRepo;
  HomeTabCategoriseUseCase({required this.moviesRepo});

  Future<Either<String, List<MovieSummaryEntity>>> call({String? genre,String? queryTerm}
      ) async {
    return await moviesRepo.getMovies(genres: genre, queryTerm: queryTerm,);
  }
}