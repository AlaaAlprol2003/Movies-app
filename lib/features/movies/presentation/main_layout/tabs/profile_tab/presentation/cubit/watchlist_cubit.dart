import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import '../../domain/use_cases/get_watch_list_movies_use_case.dart';

@injectable
class WatchListCubit extends Cubit<WatchListState> {
  final  GetWatchListMoviesUseCase getWatchListMoviesUseCase;

  WatchListCubit({required this.getWatchListMoviesUseCase}) : super(WatchListInitial());

  void getWatchList() async {
    emit(WatchListLoading());
    final result = await getWatchListMoviesUseCase();
    result.fold(
      (failure) {
        emit(WatchListError(message: failure.message));
      },
      (movies) {
        emit(WatchListSuccess(movies: movies));
      },
    );
  }
}

abstract class WatchListState {}

class WatchListInitial extends WatchListState {}

class WatchListLoading extends WatchListState {}

class WatchListError extends WatchListState {
  final String message;
  WatchListError({required this.message});
}

class WatchListSuccess extends WatchListState {
  final List<MovieSummaryEntity> movies;
  WatchListSuccess({required this.movies});
}
