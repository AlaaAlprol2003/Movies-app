import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/widgets/movie_item.dart';
import 'package:movies_app/features/movies/presentation/main_layout/main_layout_provider.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/widgets/tab_bar_item.dart';
import 'package:provider/provider.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainLayoutProvider>(context);
    return SafeArea(
      child: BlocProvider<BrowseCubit>(
        create: (context) => serviceLocator.get<BrowseCubit>()..getMovies(),
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: BlocBuilder<BrowseCubit, BrowseState>(
            builder: (context, state) {
              if (state is BrowseLoading) {
                return Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
              } else if (state is BrowseError) {
                return Center(child: Text(state.message));
              } else if (state is BrowseSuccess) {
                List<String> categories = state.genres;

                return Column(
                  children: [
                    DefaultTabController(
                      length: categories.length,
                      child: TabBar(
                        onTap: (value) {
                          final newGenre = categories[value];

                          context.read<BrowseCubit>().getMovies(
                            limit: 30,
                            genres: newGenre,
                          );

                          provider.changeTabBarItem(newGenre);
                        },
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        tabs: categories
                            .map(
                              (category) => TabBarItem(
                                categoryName: category,
                                isSelected: provider.selectedGenre == category,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
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
                            pic: state.movies[index].largeCoverImage ?? "",
                            rate: state.movies[index].rating ?? 0,
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
