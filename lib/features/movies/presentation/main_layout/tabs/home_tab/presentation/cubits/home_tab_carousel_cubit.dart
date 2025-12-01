import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/use_cases/carousel_movies_use_case.dart';
import 'cubit_states.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class HomeTabCarouselCubit extends Cubit<HomeTabCarouselState> {
  final CarouselMoviesUseCase carouselMoviesUseCase;

  HomeTabCarouselCubit({
    required this.carouselMoviesUseCase,
  }) : super(HomeTabCarouselInitial());

  Future<void> fetchCarouselMovies({int? limit}) async {
    emit(HomeTabCarouselLoading());
    final result = await carouselMoviesUseCase(limit: limit);
    result.fold(
      (failure) => emit(HomeTabCarouselOnError(failure)),
      (movies) => emit(HomeTabCarouselOnSuccess(movies)),
    );
  }


}
