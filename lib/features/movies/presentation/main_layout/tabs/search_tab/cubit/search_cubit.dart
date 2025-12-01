import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/use_cases/search_use_case.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchUseCase searchUseCase;
  SearchCubit({required this.searchUseCase}) : super(SearchInitial());

  void getMovies({String? queryTerm}) async {
    emit(SearchLoading());
    final result = await searchUseCase(queryTerm: queryTerm);
    result.fold(
      (failure) {
        emit(SearchError(message: failure));
      },
      (movies) {
        emit(SearchSuccess(movies: movies));
      },
    );
  }

  void resetSearch() {
    emit(SearchInitial());
  }
}

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  String message;
  SearchError({required this.message});
}

class SearchSuccess extends SearchState {
  List<MovieSummaryEntity> movies;
  SearchSuccess({required this.movies});
}
