import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/movie_hive.dart';

abstract class HistoryLocalDataSource {

  Future<void>addToHistory({required MovieHive movie});
  Future<List<MovieHive>> getHistory();
}