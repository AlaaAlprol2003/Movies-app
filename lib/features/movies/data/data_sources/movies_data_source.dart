import 'package:dartz/dartz.dart';
import '../models/movies/movie.dart';

abstract class MoviesDataSource {
 Future<Either<String, List<Movie>>> getMovies({int? limit, String? genres,String? queryTerm });

}