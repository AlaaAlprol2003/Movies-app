import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/movie_detials_entity.dart';
import '../../../domain/use_cases/movie_details_use_case.dart';
import 'cubit_states.dart';


@lazySingleton
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  late MovieDetailsEntity movie;

  MovieDetailsCubit({
    required this.movieDetailsUseCase,
  }) : super(MovieDetailsInitial());

  Future<void> fetchMovie({required int movieId}) async {
    emit(MovieDetailsLoading());
    final result = await movieDetailsUseCase(movieId: movieId);
    result.fold(
          (failure) => emit(MovieDetailsOnError(failure.message)),
          (movies) {
            movie = movies;
            emit(MovieDetailsOnSuccess(movies));
          }
    );
  }


}
