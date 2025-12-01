import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/browse_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_carousel_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_category_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/profile_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/search_tab.dart';

class MainLayoutProvider extends ChangeNotifier {
  late HomeTabCarouselCubit homeTabCarouselCubit = serviceLocator.get<HomeTabCarouselCubit>()..fetchCarouselMovies(limit: 5);
  late HomeTabCategoryCubit homeTabCategoryCubit = serviceLocator.get<HomeTabCategoryCubit>()..fetchCategoryMovies(genre1: genres[genreIndex], genre2: genres[genreIndex+1], genre3: genres[genreIndex+2],);
  late SearchCubit searchCubit = serviceLocator.get<SearchCubit>();
  late List<Widget> tabs = [
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: homeTabCarouselCubit),
        BlocProvider.value(value: homeTabCategoryCubit),
      ],child: HomeTab(),
    ),
    BlocProvider.value(
        value: searchCubit,
        child: SearchTab()),
    BrowseTab(),
    ProfileTab(),
  ];
  int selectedTab = 0;
  int genreIndex = 0;
  int selectedCarouselTab = 0;
  String selectedGenre = "Action";
  List<String> genres = [
    'Sport',
    'Romance',
    'Animation',
    'Adventure',
    'Anime',
    'Comedy',
    'Crime',
    'Documentary',
    'Action',
    'Drama',
    'Family',
    'Fantasy',
    'Game Show',
    'Horror',
    'Language',
    'Lifestyle',
    'Musical',
    'Mystery',
    'Sci-Fi',
    'Seasonal',
    'Short',
    'Reality TV',
    'Thriller',
    'Western',
    'Music',
  ];
  void changeTabBarItem(String genre) {
    selectedGenre = genre;
    notifyListeners();
  }

  void changeGenre(int index) {
    if(selectedTab == 0){
      if(genreIndex!=21){
        genreIndex+=3;
      }else if (genreIndex==21){
        genreIndex=0;
      }
      notifyListeners();}
  }

  void changeTab(int index) {
    changeGenre(index);
    selectedTab = index;
    notifyListeners();
  }

  void onCarouselChange(int index) {
    selectedCarouselTab = index;
    notifyListeners();
  }
}
