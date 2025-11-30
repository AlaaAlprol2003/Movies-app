import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/const_manager.dart';
import '../models/movie.dart';
import 'movies_data_source.dart';

@LazySingleton(as: MoviesDataSource)
class MoviesApiDataSource implements MoviesDataSource {
  final Dio dio = Dio(BaseOptions(baseUrl: MoviesApiConstant.baseUrl));
  
  @override
  Future<Either<String, List<Movie>>> getMovies({int? limit, String? genres}) async {
     print("API GENRE SENT => $genres"); 
    try {
      final response = await dio.get(MoviesApiConstant.moviesListEndPoint,
        queryParameters: {
          'limit': limit,
          'genre': genres,
        },);
        print("RESPONSE COUNT => ${response.data['data']['movies'].length}");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final movies = (data['movies'] as List)
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


}
