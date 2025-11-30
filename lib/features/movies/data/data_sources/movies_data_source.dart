import 'package:dartz/dartz.dart';
import '../models/movie.dart';

abstract class MoviesDataSource {
 Future<Either<String, List<Movie>>> getMovies({int? limit, String? genres });

}