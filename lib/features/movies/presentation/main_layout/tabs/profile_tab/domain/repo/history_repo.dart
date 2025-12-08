import 'package:dartz/dartz.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../../../../../../../core/errors/errors/failure.dart';
import '../../data/models/movie_hive.dart';

abstract class HistoryRepo {
  Future<Either<Failure,void>>addToHistory({required MovieHive movie});
  Future<Either<Failure,List<MovieSummaryEntity>>> getHistory();
}
