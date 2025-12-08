import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key,required this.url,this.width,this.height});

  final String url;
  final double? width;
  final double? height;


  @override
  Widget build(BuildContext context) {
      return Image.network(
        url,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            color: ColorsManager.grey,
            child: Icon(Icons.error, color: Colors.white, size: 40.sp),
          );
        },
      );
    }

}
