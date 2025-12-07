import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import '../../data/models/movie_hive.dart';
import '../../domain/repo/history_repo.dart';
import '../data_source/local_data_source/history_local_data_source.dart';


@LazySingleton(as:HistoryRepo)
class HistoryRepoImpl implements HistoryRepo {
  final HistoryLocalDataSource localDataSource;

  HistoryRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addToHistory({required MovieHive movie}) async {
    try {
      await localDataSource.addToHistory(movie: movie);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieSummaryEntity>>> getHistory() async {
    try {
      final hiveMovies = await localDataSource.getHistory();
      final history = hiveMovies.map((m) {
        return MovieSummaryEntity(
          id: m.id,
          mediumCoverImage: m.photo,
          rating: m.rating,
        );
      }).toList();
      return Right(history);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
