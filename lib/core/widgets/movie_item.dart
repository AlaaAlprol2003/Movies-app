import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/watchlist_cubit.dart';

import '../../features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/get_history_cubit.dart';
import 'custom_network_image.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key,required this.movie ,this.width,this.height});

 final MovieSummaryEntity movie;
 final double? width;
 final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.pushNamed(context,RoutesManager.movieDetails,arguments: movie.id,).then((value) => value == true ? {context.read<WatchListCubit>().getWatchList(),
          context.read<GetHistoryCubit>().getHistory() } : null);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomNetworkImage(
              url: movie.mediumCoverImage,
              width: width,
              height: height,
            )
          ),
          Positioned(
            top: 10.h,
            left: 8.w,
            child: Container(
              padding: REdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorsManager.black.withValues(alpha:.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    "${movie.rating}",
                    style: TextStyle(
                        color: ColorsManager.white, fontSize: 16.sp
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.star,
                    color: ColorsManager.yellow,
                    size: 16.sp,
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
