import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:safe_network_image/safe_network_image.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.pic, required this.rate,required this.movieId,this.isCategory});

 final String pic;
 final double rate;
 final int movieId;
 final bool? isCategory;

 @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.pushNamed(context,RoutesManager.movieDetails,arguments: movieId);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SafeNetworkImage(
              url: pic,
              fit: BoxFit.cover,
              width: isCategory==true?140.w: double.infinity,
              height:isCategory==true?200.h: double.infinity,
            )
          ),
          Positioned(
            top: 10.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorsManager.black.withValues(alpha:.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    "$rate",
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
