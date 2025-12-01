import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/widgets/movie_item.dart';
import 'package:movies_app/features/movies/presentation/main_layout/main_layout_provider.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/widgets/tab_bar_item.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/movie_summary_entity.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainLayoutProvider>(context);
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
       child: Column(
                children: [
                  DefaultTabController(
                    initialIndex: provider.browseGenreIndex,
                    length: provider.genres.length,
                    child: TabBar(
                      onTap: (index){
                        provider.changeBrowseTabBar(index);
                        provider.browseCubit.getMovies(limit: 30, genres: provider.genres[index]);
                      },
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      tabs: List.generate(
                        provider.genres.length,
                            (index) => TabBarItem(
                          categoryName: provider.genres[index]
                              .toString(),
                          isSelected: index == provider.browseGenreIndex,
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<BrowseCubit, BrowseState>(
                    builder: (context, state) {
                      if (state is BrowseLoading) {
                        return Expanded(
                          child: Center(child: CircularProgressIndicator(
                              color: ColorsManager.yellow)),
                        );
                      } else if (state is BrowseError) {
                        return Center(child: Text(state.message));
                      } else if (state is BrowseSuccess) {
                        List<MovieSummaryEntity> movies = state.movies;
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 8.h,
                              childAspectRatio: 7 / 10,
                            ),
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              return MovieItem(
                                pic: movies[index].mediumCoverImage ??'',
                                rate: movies[index].rating??0.0,
                              );
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },

                  ),

                ],
              )
      )
    );
  }
}
