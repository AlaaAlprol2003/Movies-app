import '../../../domain/entities/movie_detials_entity.dart';
import '../../../domain/entities/movie_summary_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsOnError extends MovieDetailsState {
  final String message;

  MovieDetailsOnError(this.message);
}

class MovieDetailsOnSuccess extends MovieDetailsState {
  final MovieDetailsEntity movie;

  MovieDetailsOnSuccess(this.movie);
}
///===========================================================
abstract class MovieSuggestionsState {}

class MovieSuggestionsInitial extends MovieSuggestionsState {}

class MovieSuggestionsLoading extends MovieSuggestionsState {}

class MovieSuggestionsOnError extends MovieSuggestionsState {
  final String message;

  MovieSuggestionsOnError(this.message);
}

class MovieSuggestionsOnSuccess extends MovieSuggestionsState {
  final List<MovieSummaryEntity> movies;

  MovieSuggestionsOnSuccess(this.movies);
}

///=====================================================================
abstract class IsWatchListState {}

class IsWatchListInitial extends IsWatchListState {}

class IsWatchListLoading extends IsWatchListState {}

class IsWatchListError extends IsWatchListState {
  final String message;
  IsWatchListError({required this.message});
}

class IsWatchListUpdated extends IsWatchListState {
  final bool isAdded;
  IsWatchListUpdated({required this.isAdded});
}

