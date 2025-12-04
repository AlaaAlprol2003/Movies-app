import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/movie_item.dart';
import '../../../domain/entities/movie_summary_entity.dart';

class SimilarDisplay extends StatelessWidget {
  const SimilarDisplay({super.key, required this.movies});

 final List<MovieSummaryEntity>? movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: movies?.length?? 0,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 7/10,
      ),
      itemBuilder: (context, index) {
        return MovieItem(pic: movies![index].mediumCoverImage, rate: movies![index].rating,movieId: movies![index].id,
        height: 265.h,
        width: double.infinity,);
      },
    );
  }
}
