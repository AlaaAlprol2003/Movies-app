import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Watch_list_response.dart';
import '../../models/Is_added_to_watch_list.dart';
import '../../models/watch_list_request.dart';

abstract class WatchListDataSource{
  Future<void> addMovieToWatchList({required WatchListRequest request, required String token});
  Future<WatchListResponse> getWatchListMovies({required String token});
  Future<void> deleteMovieFromWatchList({required String token, required String movieId});
  Future<IsAddedToWatchList> isAddedToWatchList({required String token, required String movieId});
}