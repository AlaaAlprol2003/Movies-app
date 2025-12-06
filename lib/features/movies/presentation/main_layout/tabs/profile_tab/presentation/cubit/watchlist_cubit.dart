import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';

import '../../../../../../domain/use_cases/search_use_case.dart';

@injectable
class WatchListCubit extends Cubit<WatchListState> {
  final SearchUseCase getWatchListUseCase;

  WatchListCubit({required this.getWatchListUseCase}) : super(WatchListInitial());

  void getWatchList() async {
    emit(WatchListLoading());
    final result = await getWatchListUseCase();
    result.fold(
      (failure) {
        emit(WatchListError(message: failure));
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
