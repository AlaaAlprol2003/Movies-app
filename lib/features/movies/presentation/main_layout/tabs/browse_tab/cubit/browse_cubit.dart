import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/use_cases/browse_use_case.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  BrowseUseCase browseUseCase;
  BrowseCubit({required this.browseUseCase}) : super(BrowseInitial());

  void getMovies({ int? limit , String? genres}) async {
    emit(BrowseLoading());
    final result = await browseUseCase( limit: limit, genres: genres);
    result.fold(
      (failure) {
        emit(BrowseError(message: failure));
      },
      (movies) {
        emit(BrowseSuccess(movies: movies));
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
  BrowseSuccess({required this.movies,});
}
