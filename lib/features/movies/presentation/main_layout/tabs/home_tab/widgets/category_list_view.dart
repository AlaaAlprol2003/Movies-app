import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/resources/colors_manager.dart';
import '../../../../../../../../core/widgets/movie_item.dart';
import '../../../../../../../core/resources/const_manager.dart';
import '../../../../../domain/entities/movie_summary_entity.dart';
import '../../../main_layout_provider.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.categoryName,
    required this.movies,
    required this.genreIndex,
  });

  final String categoryName;
  final List<MovieSummaryEntity> movies;
  final int genreIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayoutProvider>(context);
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  color: ColorsManager.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  provider.changeBrowseTabBar(genreIndex);
                  provider.browseCubit.getMovies(limit: 30, genres: MoviesGenres.genres[genreIndex]);
                  provider.changeTab(2);
                },
                child: Row(
                  children: [
                    Text(
                      "See More ",
                      style: TextStyle(
                        color: ColorsManager.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: ColorsManager.yellow,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieItem(
                movie: movies[index],
                width: 140.w,
                height: 200.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
