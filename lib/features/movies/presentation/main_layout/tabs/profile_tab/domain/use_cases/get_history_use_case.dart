import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/history_repo.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/watch_list_repo.dart';

import '../../../../../../../../core/errors/errors/failure.dart';
import '../../../../../../domain/entities/movie_summary_entity.dart';
import '../../data/models/movie_hive.dart';
import '../../data/models/watch_list_request.dart';

@lazySingleton
class GetHistoryUseCase{
  HistoryRepo historyRepo;
  GetHistoryUseCase({required this.historyRepo});

  Future<Either<Failure, List<MovieSummaryEntity>>> call() async {
    return await historyRepo.getHistory();
  }
}