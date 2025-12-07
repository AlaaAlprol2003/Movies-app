import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/widgets/animated_movie_bg.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/widgets/category_list_view.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/resources/colors_manager.dart';
import '../../../../../../core/widgets/movie_item.dart';
import '../../main_layout_provider.dart';
import 'cubits/cubit_states.dart';
import 'cubits/home_tab_carousel_cubit.dart';
import 'cubits/home_tab_category_cubit.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  MainLayoutProvider? _provider;
  bool _fetched = false;
  int? _lastGenreIndex;

  @override
  void initState() {
    super.initState();
    // هضيف الليسنر هنا بدل didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _provider ??= Provider.of<MainLayoutProvider>(context, listen: false);

    // أضمن إني أضيف الليسنر مرة واحدة فقط
    _provider!.removeListener(_onGenreChange);
    _provider!.addListener(_onGenreChange);

    final cubit = context.read<HomeTabCategoryCubit>();

    if (!_fetched) {
      cubit.fetchCategoryMovies(
        genre1: _provider!.genres[_provider!.genreIndex],
        genre2: _provider!.genres[_provider!.genreIndex + 1],
        genre3: _provider!.genres[_provider!.genreIndex + 2],
      );
      _fetched = true;
      _lastGenreIndex = _provider!.genreIndex;
    }
  }

  void _onGenreChange() {
    if (!mounted) return;

    if (_provider == null) return;

    if (_lastGenreIndex == _provider!.genreIndex) return;
    _lastGenreIndex = _provider!.genreIndex;

    final cubit = context.read<HomeTabCategoryCubit>();

    cubit.fetchCategoryMovies(
      genre1: _provider!.genres[_provider!.genreIndex],
      genre2: _provider!.genres[_provider!.genreIndex + 1],
      genre3: _provider!.genres[_provider!.genreIndex + 2],
    );
  }

  @override
  void dispose() {
    _provider?.removeListener(_onGenreChange);
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
                return Padding(
                  padding: REdgeInsets.symmetric(vertical: 300),
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: ColorsManager.red),
                    ),
                  ),
                );
              } else if (state is HomeTabCarouselOnSuccess) {
                final movies = state.movies;
                print(movies[0].id );
                print(movies[0].rating);
                print(movies[0].mediumCoverImage );
                return SizedBox(
                  height: 600.h,
                  child: Stack(
                    children: [
                      AnimatedMovieBg(
                          pic: movies[provider.selectedCarouselTab]
                              .mediumCoverImage),
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
                                pic: movie.mediumCoverImage,
                                rate: movie.rating,
                                movieId: movie.id,
                              ),
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

          BlocBuilder<HomeTabCategoryCubit, HomeTabCategoryState>(
            builder: (context, state) {
              if (state is HomeTabCategoryLoading) {
                return SizedBox(
                  height: 300.h,
                  child: const Center(
                      child: CircularProgressIndicator()),
                );
              } else if (state is HomeTabCategoryOnError) {
                return Padding(
                  padding: REdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: ColorsManager.red),
                    ),
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
                        movies: category1,genreIndex: provider.genreIndex,),
                    CategoryListView(
                        categoryName:
                        provider.genres[provider.genreIndex + 1], // genre2
                        movies: category2,genreIndex: provider.genreIndex+1,),
                    CategoryListView(
                        categoryName:
                        provider.genres[provider.genreIndex + 2], // genre3
                        movies: category3,genreIndex: provider.genreIndex+2,),
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
