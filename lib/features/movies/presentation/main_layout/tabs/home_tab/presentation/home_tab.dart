import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/widgets/movie_gradient.dart';
import 'package:movies_app/core/widgets/movie_item.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/cubit_states.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_carousel_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_category_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/widgets/category_list_view.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/resources/colors_manager.dart';
import '../../../main_layout_provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
   bool _fetched = false;
  int? _lastGenreIndex;
  late MainLayoutProvider _provider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = Provider.of<MainLayoutProvider>(context, listen: false);
    final cubit = context.read<HomeTabCategoryCubit>();

    if (!_fetched) {
      cubit.fetchCategoryMovies(
        genre1: _provider.genres[_provider.genreIndex],
        genre2: _provider.genres[_provider.genreIndex + 1],
        genre3: _provider.genres[_provider.genreIndex + 2],
      );
      _fetched = true;
      _lastGenreIndex = _provider.genreIndex;
    }

    _provider.addListener(_onGenreChange);
  }

  void _onGenreChange() {
    if (!mounted) return; 

  if (_lastGenreIndex == _provider.genreIndex) return;
  _lastGenreIndex = _provider.genreIndex;

  final cubit = context.read<HomeTabCategoryCubit>();
  cubit.fetchCategoryMovies(
    genre1: _provider.genres[_provider.genreIndex],
    genre2: _provider.genres[_provider.genreIndex + 1],
    genre3: _provider.genres[_provider.genreIndex + 2],
  );
  }

  @override
  void dispose() {
    _provider.removeListener(_onGenreChange);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayoutProvider>(context);

    return SingleChildScrollView(
      padding: REdgeInsets.only(bottom: 75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<HomeTabCarouselCubit, HomeTabCarouselState>(
            builder: (context, state) {
              if (state is HomeTabCarouselLoading) {
                return SizedBox(
                  height: 600.h,
                  child: const Center(
                      child: CircularProgressIndicator(
                      )),
                );
              } else if (state is HomeTabCarouselOnError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: ColorsManager.red),
                  ),
                );
              } else if (state is HomeTabCarouselOnSuccess) {
                final movies = state.movies;
                return SizedBox(
                  height: 600.h,
                  child: Stack(
                    children: [
                      MovieGradient(
                          pic: movies[provider.selectedCarouselTab]
                              .mediumCoverImage ??
                              ''),
                      Padding(
                        padding: REdgeInsets.symmetric(vertical: 130),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              provider.onCarouselChange(index);
                            },
                            height: double.infinity,
                            enlargeCenterPage: true,
                            enlargeFactor: .4,
                            viewportFraction: .6,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 1500),
                            scrollPhysics: const BouncingScrollPhysics(),
                          ),
                          items: movies
                              .map(
                                (movie) => MovieItem(
                                pic: movie.mediumCoverImage ?? '',
                                rate: movie.rating ?? 0.0),
                          )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),

          // Category Lists
          BlocBuilder<HomeTabCategoryCubit, HomeTabCategoryState>(
            builder: (context, state) {
              if (state is HomeTabCategoryLoading) {
                return SizedBox(
                  height: 300.h,
                  child: const Center(
                      child: CircularProgressIndicator()),
                );
              } else if (state is HomeTabCategoryOnError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: ColorsManager.red),
                  ),
                );
              } else if (state is HomeTabCategoryOnSuccess) {
                final category1 = state.category1;
                final category2 = state.category2;
                final category3 = state.category3;

                return Column(
                  children: [
                    CategoryListView(
                        categoryName:
                        provider.genres[provider.genreIndex], // genre1
                        movies: category1),
                    CategoryListView(
                        categoryName:
                        provider.genres[provider.genreIndex + 1], // genre2
                        movies: category2),
                    CategoryListView(
                        categoryName:
                        provider.genres[provider.genreIndex + 2], // genre3
                        movies: category3),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
