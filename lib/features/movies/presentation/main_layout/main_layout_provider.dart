import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/browse_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/profile_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/search_tab.dart';

class MainLayoutProvider extends ChangeNotifier {
  late HomeTabCubit homeTabCubit = serviceLocator.get<HomeTabCubit>()
    ..fetchMovies(limit: 10);
  int selectedTab = 0;
  late List<Widget> tabs = [
    BlocProvider.value(value: homeTabCubit, child: HomeTab()),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];
  int selectedCarouselTab = 0;
  String selectedGenre = "Action";
  void changeTabBarItem(String genre) {
    selectedGenre = genre;
    notifyListeners();
  }

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void onCarouselChange(int index) {
    selectedCarouselTab = index;
    notifyListeners();
  }
}
