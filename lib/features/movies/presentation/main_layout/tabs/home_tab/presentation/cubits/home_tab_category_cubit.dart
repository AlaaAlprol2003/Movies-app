import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../domain/entities/movie_summary_entity.dart';
import '../../../../../../domain/use_cases/home_tab_categorise_use_case.dart';
import 'cubit_states.dart';

@injectable
class HomeTabCategoryCubit extends Cubit<HomeTabCategoryState> {
  final HomeTabCategoriseUseCase homeTabCategoriseUseCase;
  HomeTabCategoryCubit({
    required this.homeTabCategoriseUseCase,
  }) : super(HomeTabCategoryInitial());

  List<MovieSummaryEntity>? category1;
  List<MovieSummaryEntity>? category2;
  List<MovieSummaryEntity>? category3;


  Future<void> fetchCategoryMovies({
    required String genre1,
    required String genre2,
    required String genre3,
  }) async {
    emit(HomeTabCategoryLoading());

    final result1 = await homeTabCategoriseUseCase(genre: genre1);
    result1.fold(
          (failure) {
        emit(HomeTabCategoryOnError(failure));
        return;
      },
          (movies) => category1 = movies,
    );
    if (state is HomeTabCategoryOnError) return;


    final result2 = await homeTabCategoriseUseCase(genre: genre2);
    result2.fold(
          (failure) {
        emit(HomeTabCategoryOnError(failure));
        return;
      },
          (movies) => category2 = movies,
    );
    if (state is HomeTabCategoryOnError) return;

    final result3 = await homeTabCategoriseUseCase(genre: genre3);
    result3.fold(
          (failure) {
        emit(HomeTabCategoryOnError(failure));
        return;
      },
          (movies) => category3 = movies,
    );
    if (state is HomeTabCategoryOnError) return;


    emit(HomeTabCategoryOnSuccess(category1!, category2!, category3!));
  }

}
