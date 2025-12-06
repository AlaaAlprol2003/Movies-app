import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../models/movie.dart';

abstract class MoviesDataSource {
 Future<Either<String, List<Movie>>> getMovies({int? limit, String? genres,String? queryTerm });

}