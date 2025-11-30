import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/use_cases/browse_use_case.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  BrowseUseCase browseUseCase;
  BrowseCubit({required this.browseUseCase}) : super(BrowseInitial());

  void getMovies({String? genres, int? limit}) async {
    emit(BrowseLoading());
    print("GENRE REQUESTED => $genres");
    final result = await browseUseCase(genres: genres, limit: limit);
    result.fold(
      (failure) {
        emit(BrowseError(message: failure));
      },
      (movies) {
        List<String> allGenres = movies
            .where((m) => m.genres != null && m.genres!.isNotEmpty)
            .expand((m) => m.genres!)
            .toSet()
            .toList();

        emit(BrowseSuccess(movies: movies, genres: allGenres));
      },
    );
  }
}

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseError extends BrowseState {
  String message;
  BrowseError({required this.message});
}

class BrowseSuccess extends BrowseState {
  List<MovieSummaryEntity> movies;
  List<String> genres;
  BrowseSuccess({required this.movies, required this.genres});
}
