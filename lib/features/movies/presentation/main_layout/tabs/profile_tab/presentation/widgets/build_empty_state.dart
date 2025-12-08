import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors_manager.dart';


class BuildEmptyState extends StatelessWidget {
  const BuildEmptyState({super.key, required this.imagePath, required this.message});

  final String imagePath;
  final String message;


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150.w,
            height: 150.h,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.movie_outlined,
                size: 100.sp,
                color: ColorsManager.yellow,
              );
            },
          ),
          SizedBox(height: 20.h),
          Text(
            message,
            style: TextStyle(color: ColorsManager.grey, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
