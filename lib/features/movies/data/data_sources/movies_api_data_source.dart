import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/const_manager.dart';
import '../models/movie.dart';
import 'movies_data_source.dart';

@Singleton(as: MoviesDataSource)
class MoviesApiDataSource implements MoviesDataSource {
  final Dio dio = Dio(BaseOptions(baseUrl: MoviesApiConstant.baseUrl));

  @override
  Future<Either<String, List<Movie>>> getMovies({
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
          return Right([]);
        }

        final movies = (moviesList as List)
            .map((json) => Movie.fromJson(json))
            .toList();

        return Right(movies);
      } else {
        return Left('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }


  @override
  Future<Either<String, List<Movie>>> getWatchList() async {
    // TODO: Implement actual API call
    // For now returning empty list or mock data
    return Right([]);
  }

  @override
  Future<Either<String, List<Movie>>> getHistory() async {
    // TODO: Implement actual API call
    // For now returning empty list or mock data
    return Right([]);
  }
}
