import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';import '../../domain/use_cases/get_history_use_case.dart';


@lazySingleton
class GetHistoryCubit extends Cubit<GetHistoryState>{
  GetHistoryCubit({required this.getHistoryUseCase}) : super(GetHistoryInitial());
  GetHistoryUseCase getHistoryUseCase;

  Future<void> getHistory() async {
    emit(GetHistoryLoading());
    final result = await getHistoryUseCase();
    result.fold(
          (error) =>emit(GetHistoryError(message: error.message)),
          (movies) => emit(GetHistorySuccess(movies: movies)),
    );
  }
}

abstract class GetHistoryState {}

class GetHistoryInitial extends GetHistoryState {}

class GetHistoryLoading extends GetHistoryState {}

class GetHistoryError extends GetHistoryState {
  final String message;
  GetHistoryError({required this.message});
}

class GetHistorySuccess extends GetHistoryState {
List<MovieSummaryEntity> movies;
GetHistorySuccess({required this.movies});
}
