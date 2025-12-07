import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../main_layout/tabs/profile_tab/data/models/watch_list_request.dart';
import '../../main_layout/tabs/profile_tab/domain/use_cases/add_watch_list_use_case.dart';
import '../../main_layout/tabs/profile_tab/domain/use_cases/delete_movie_from__watch_list_use_case.dart';
import '../../main_layout/tabs/profile_tab/domain/use_cases/is_add_to_watch_list_use_case.dart';
import 'cubit_states.dart';

@lazySingleton
class IsWatchListCubit extends Cubit<IsWatchListState> {
  final AddWatchListUseCase addWatchListUseCase;
  final DeleteWatchListUseCase deleteWatchListUseCase;
  final IsAddToWatchListUseCase isAddToWatchListUseCase;

  final String movieId;

  bool isAdded = false;

  IsWatchListCubit({
    required this.addWatchListUseCase,
    required this.deleteWatchListUseCase,
    required this.isAddToWatchListUseCase,
    required this.movieId,
  }) : super(IsWatchListInitial());

  Future<void> checkIfAdded() async {
    emit(IsWatchListLoading());
    final result = await isAddToWatchListUseCase(movieId: movieId);
    result.fold(
          (error) {
            print(error.message);
            emit(IsWatchListError(message: error.message));},
          (added) {
        isAdded = added ;
        print(isAdded);
        emit(IsWatchListUpdated(
          isAdded: isAdded,
        ));
      },
    );
  }

  Future<void> toggle({required WatchListRequest request}) async {
    emit(IsWatchListLoading());

    final result = isAdded
        ? await deleteWatchListUseCase(movieId: movieId)
        : await addWatchListUseCase(request: request);

    result.fold(
          (error) {

        emit(IsWatchListError(message: error.message));
      },
          (_) {
        isAdded = !isAdded;
        // Emit a state that carries the new value
        emit(IsWatchListUpdated(isAdded: isAdded));
      },
    );
  }

}
