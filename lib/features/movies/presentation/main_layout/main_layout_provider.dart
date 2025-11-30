import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/browse_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/profile_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/search_tab.dart';
import '../../data/data_sources/movies_api_data_source.dart';
import '../../data/repos_impl/movies_repo_impl.dart';
import '../../domain/use_cases/carousel_movies_use_case.dart';

class MainLayoutProvider extends ChangeNotifier {
  int selectedTab = 0;
  List<Widget> tabs = [
    BlocProvider(
      create: (context) => HomeTabCubit(
        carouselMoviesUseCase: CarouselMoviesUseCase(
          moviesRepo: MoviesRepoImpl(
            dataSource: MoviesApiDataSource(
              dio: Dio(),
            ),
        )
      ),
  )..fetchMovies(
        limit: 5,
      ),
      child: HomeTab(),
    ),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];
  int selectedCarouselTab= 0;

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void onCarouselChange(int index){
    selectedCarouselTab = index;
    notifyListeners();
  }
}
