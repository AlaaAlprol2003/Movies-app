import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/failure.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import '../../domain/repo/watch_list_repo.dart';
import '../data_source/remote_data_source/watch_list_data_source.dart';
import '../models/watch_list_request.dart';

@LazySingleton(as:WatchListRepo )
class WatchListRepoImpl implements WatchListRepo{
  final WatchListDataSource watchListDataSource;
  WatchListRepoImpl({required this.watchListDataSource});
  @override
  Future<Either<Failure, void>> addMovieToWatchList({required WatchListRequest request,})async {
   try {
    String token = await AuthSharedPrefsLocalDataSource().getToken();
    watchListDataSource.addMovieToWatchList(request: request, token: token);
    return const Right(null);
  }on AppExceptions catch (exception) {
     return Left(Failure(message: exception.message));
   }
  }

  @override
  Future<Either<Failure, List<MovieSummaryEntity>>> getWatchListMovies()async {
   try{
     String token = await AuthSharedPrefsLocalDataSource().getToken();
     final response = await watchListDataSource.getWatchListMovies( token: token);
     return Right(response.movies.map((movie) => movie.toMovieSummaryEntity()).toList());
   }catch (exception) {
     return Left(Failure(message: exception.toString()));
   }

  }

  @override
  Future<Either<Failure, void>> deleteMovieFromWatchList({required String movieId}) async{
    try {
      String token = await AuthSharedPrefsLocalDataSource().getToken();
     await watchListDataSource.deleteMovieFromWatchList(movieId: movieId, token: token);
      return const Right(null);
    }on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isAddedToWatchList({required String movieId}) async{
    try {
      String token = await AuthSharedPrefsLocalDataSource().getToken();
    final response =await watchListDataSource.isAddedToWatchList(movieId: movieId, token: token);
      return  Right(response.isAdded);
    }on AppExceptions catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

}