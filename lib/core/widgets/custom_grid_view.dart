import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/movies/domain/entities/movie_summary_entity.dart';
import 'movie_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.movies, required this.crossAxisCount});

  final List<MovieSummaryEntity> movies;
  final  int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: REdgeInsets.all(16),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(movie: movies[index]);
      },
    );
  }
}
