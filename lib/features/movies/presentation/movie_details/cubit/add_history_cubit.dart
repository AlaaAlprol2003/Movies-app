import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/add_history_use_case.dart';

import '../../main_layout/tabs/profile_tab/data/models/movie_hive.dart';
import 'cubit_states.dart';

@lazySingleton
class AddHistoryCubit extends Cubit<AddHistoryState>{
  AddHistoryCubit({required this.addHistoryUseCase}) : super(AddHistoryInitial());
  AddHistoryUseCase addHistoryUseCase;

  Future<void> addHistory({required MovieHive movie}) async {
    emit(AddHistoryLoading());
    final result = await addHistoryUseCase(movie: movie);
    result.fold(
          (error) =>emit(AddHistoryError(message: error.message)),
          (_) => emit(AddHistorySuccess()),
    );
  }
}