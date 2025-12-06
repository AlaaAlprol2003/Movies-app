import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/domain/use_cases/get_history_use_case.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;

  HistoryCubit({required this.getHistoryUseCase}) : super(HistoryInitial());

  void getHistory() async {
    emit(HistoryLoading());
    final result = await getHistoryUseCase();
    result.fold(
      (failure) {
        emit(HistoryError(message: failure));
      },
      (movies) {
        emit(HistorySuccess(movies: movies));
      },
    );
  }
}

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryError extends HistoryState {
  final String message;
  HistoryError({required this.message});
}

class HistorySuccess extends HistoryState {
  final List<MovieSummaryEntity> movies;
  HistorySuccess({required this.movies});
}
