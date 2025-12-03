import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../core/resources/colors_manager.dart';
import '../../../../../../../../core/widgets/movie_item.dart';
import '../../../../../domain/entities/movie_summary_entity.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.categoryName,
    required this.movies,
  });

  final String categoryName;
  final List<MovieSummaryEntity> movies;

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
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
                pic: movies[index].mediumCoverImage ?? '',
                rate: movies[index].rating ?? 0.0,
                movieId: movies[index].id ?? 0,
                width: 140,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
