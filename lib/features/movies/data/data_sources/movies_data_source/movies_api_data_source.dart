import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/const_manager.dart';
import '../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../core/errors/errors/dio_exceptions.dart';
import '../../../../../core/errors/errors/failure.dart';
import '../../models/movies/movie.dart';
import 'movies_data_source.dart';

@Singleton(as: MoviesDataSource)
class MoviesApiDataSource implements MoviesDataSource {
  final Dio dio = Dio(BaseOptions(baseUrl: MoviesApiConstant.baseUrl));

  @override
  Future<Either<Failure, List<Movie>>> getMovies({
    int? limit,
    String? genres,
    String? queryTerm,
  }) async {
    try {
      final response = await dio.get(
        MoviesApiConstant.moviesListEndPoint,
        queryParameters: {
          'limit': limit,
          'genre': genres,
          'query_term': queryTerm,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final moviesList = data['movies'];
        if (moviesList == null) {
          return Left(Failure(message: "No movies found for your search."));
        }

        final movies = (moviesList as List)
            .map((json) => Movie.fromJson(json))
            .toList();

        return Right(movies);
      } else {
        throw RemoteException(message: "Server error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      return Left(Failure(message: handleDioError(e).message));
    }catch (e) {
      return Left(Failure(message: "Unexpected error occurred. Please try again."));
    }
  }

}
