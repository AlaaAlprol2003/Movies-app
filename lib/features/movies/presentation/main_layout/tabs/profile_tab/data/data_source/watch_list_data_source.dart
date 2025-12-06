abstract class WatchListDataSource{
  Future<void> addMovieToWatchList({required String movieId, required String token});
}