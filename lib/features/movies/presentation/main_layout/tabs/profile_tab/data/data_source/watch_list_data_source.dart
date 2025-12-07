import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Watch_list_response.dart';

abstract class WatchListDataSource{
  Future<void> addMovieToWatchList({required String movieId, required String token});
  Future<WatchListResponse> getWatchListMovies({required String token});
}