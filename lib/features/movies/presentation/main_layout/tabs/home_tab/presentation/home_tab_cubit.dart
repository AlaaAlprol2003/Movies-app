import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/use_cases/carousel_movies_use_case.dart';
import '../../../../../domain/entities/movie_summary_entity.dart';


class HomeTabCubit extends Cubit<HomeTabState> {
  final CarouselMoviesUseCase carouselMoviesUseCase;

  HomeTabCubit({required this.carouselMoviesUseCase}) : super(HomeTabInitial());

  Future<void> fetchMovies(
      {int? limit}
      ) async {
    emit(HomeTabLoading());
    final result = await carouselMoviesUseCase(
      limit: limit ,
    );
    result.fold(
          (failure) => emit(HomeTabOnError(failure)),
          (movies) => emit(HomeTabOnSuccess(movies)),
    );
  }
}

abstract class HomeTabState {}

class HomeTabInitial extends HomeTabState {}
class HomeTabLoading extends HomeTabState {}
class HomeTabOnError extends HomeTabState {
  final String message;
  HomeTabOnError(this.message);
}
class HomeTabOnSuccess extends HomeTabState {
  final List<MovieSummaryEntity> movies;
  HomeTabOnSuccess(this.movies);
}

