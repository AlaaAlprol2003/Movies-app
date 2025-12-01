import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';

class MovieGradient extends StatelessWidget {
  const MovieGradient({super.key, required this.pic});

  final String pic;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: Stack(
        key: ValueKey<String>(pic),
        children: [
          Image.network(
            pic,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator(
                  color: ColorsManager.white,
                )),
              );
            },
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorsManager.black.withValues(alpha: .8),
                  ColorsManager.black.withValues(alpha: .6),
                  ColorsManager.black.withValues(alpha: 1),
                ],
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 60,
            child: Image.asset(
              ImagesAssets.availableWatchNowMovie,
              fit: BoxFit.cover,
              height: 550.h,
            ),
          ),
        ],
      ),
    );
  }
}
