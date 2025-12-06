import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/repos/movies_repo.dart';

@injectable
class GetHistoryUseCase {
  final MoviesRepo moviesRepo;

  GetHistoryUseCase({required this.moviesRepo});

  Future<Either<String, List<MovieSummaryEntity>>> call() async {
    return await moviesRepo.getHistory();
  }
}
