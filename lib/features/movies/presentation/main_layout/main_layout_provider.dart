import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/browse_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/cubits/home_tab_carousel_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/cubits/home_tab_category_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/home_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/history_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/profile_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/watchlist_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/screens/profile_tab.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/search_tab.dart';

class MainLayoutProvider extends ChangeNotifier {
  late HomeTabCarouselCubit homeTabCarouselCubit = serviceLocator.get<HomeTabCarouselCubit>()..fetchCarouselMovies(limit: 5);
  late HomeTabCategoryCubit homeTabCategoryCubit = serviceLocator.get<HomeTabCategoryCubit>()..fetchCategoryMovies(genre1: genres[genreIndex],
    genre2: genres[genreIndex+1],
    genre3: genres[genreIndex+2],);
  late ProfileCubit profileCubit = serviceLocator.get<ProfileCubit>()..getUser();
  late WatchListCubit watchListCubit = serviceLocator.get<WatchListCubit>();
  late HistoryCubit historyCubit = serviceLocator.get<HistoryCubit>();
  late SearchCubit searchCubit = serviceLocator.get<SearchCubit>();
  late BrowseCubit browseCubit = serviceLocator.get<BrowseCubit>()..getMovies(limit: 30,);
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
    BlocProvider.value(
      value: browseCubit,
        child: BrowseTab()),
    ProfileTab(),
  ];
  int selectedTab = 0;
  int genreIndex = 0;
  int browseGenreIndex = 0;
  int selectedCarouselTab = 0;
  String searchKey = '';
  List<String> genres = [
    'Crime',
    'Romance',
    'Animation',
    'Adventure',
    'Comedy',
    'Sport',
    'Documentary',
    'Action',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Musical',
    'Mystery',
    'Sci-Fi',
    'Thriller',
    'Western',
    'Music',
  ];


  void changeGenre(int index) {
    if(selectedTab == 0){
      if(genreIndex!=15){
        genreIndex+=3;
      }else if (genreIndex==15){
        genreIndex=0;
      }
      notifyListeners();}
  }

  void changeTab(int index) {
    changeGenre(index);
    selectedTab = index;
    notifyListeners();
  }

  void changeBrowseTabBar(int index) {
    browseGenreIndex = index;
    notifyListeners();
  }

  void onSearchChange(String input,BuildContext context) {
    searchKey = input;
    if (input.trim().isEmpty) {
      context.read<SearchCubit>().resetSearch();
    } else {
      context.read<SearchCubit>().getMovies(queryTerm: input);
    }
    notifyListeners();
  }


  void onCarouselChange(int index) {
    selectedCarouselTab = index;
    notifyListeners();
  }
}
