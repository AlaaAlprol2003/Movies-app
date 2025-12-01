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
import '../../../../../domain/entities/movie_summary_entity.dart';
import '../../../main_layout_provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

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
                  child: const Center(child: CircularProgressIndicator(
                    color: ColorsManager.white,)),
                );
              } else if (state is HomeTabCarouselOnError) {
                return Center(child: Text(state.message,style: TextStyle(color: ColorsManager.red),));
              }
              else if (state is HomeTabCarouselInitial) {
                return Container();
              } else if (state is HomeTabCarouselOnSuccess) {
                List<MovieSummaryEntity> movies = state.movies;
                return
                  SizedBox(
                    height: 600.h,
                    child: Stack(
                      children: [
                        MovieGradient(pic: movies[provider.selectedCarouselTab]
                            .mediumCoverImage ?? ''),
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
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(
                                    milliseconds: 1500),
                                scrollPhysics: BouncingScrollPhysics(),

                              ),
                              items: movies.map((movie) =>
                                  MovieItem(pic: movie.mediumCoverImage ?? '',
                                      rate: movie.rating ?? 0.0)).toList()
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
                  child: const Center(child: CircularProgressIndicator(
                    color: ColorsManager.white,)),
                );
              } else if (state is HomeTabCategoryOnError) {
                return Center(child: Text(state.message,style:TextStyle(color: ColorsManager.red),));
              }
              else if (state is HomeTabCategoryInitial) {
                return Container();
              } else if (state is HomeTabCategoryOnSuccess) {
                List<MovieSummaryEntity> category1 = state.category1;
                List<MovieSummaryEntity> category2 = state.category2;
                List<MovieSummaryEntity> category3 = state.category3;
                return
                  Column(
                    children: [
                      CategoryListView(categoryName: provider.genres[provider.genreIndex], movies: category1),
                      CategoryListView(categoryName: provider.genres[provider.genreIndex+1], movies: category2),
                      CategoryListView(categoryName: provider.genres[provider.genreIndex+2], movies: category3),
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
