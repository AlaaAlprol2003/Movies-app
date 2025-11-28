import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 12,vertical: 20),
      padding: REdgeInsets.symmetric(horizontal: 33,vertical: 19),
      decoration: BoxDecoration(
        color: ColorsManager.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navItem(
            icon: AssetsManager.homeIcon,
            index: 0,
          ),
          navItem(
            icon: AssetsManager.searchIcon,
            index: 1,
          ),
          navItem(
            icon: AssetsManager.exploreIcon,
            index: 2,
          ),
          navItem(
            icon: AssetsManager.profileIcon,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget navItem({required String icon, required int index}) {
    final bool selected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
        child: SvgPicture.asset(
         icon ,
          colorFilter: ColorFilter.mode(
            selected ? ColorsManager.yellow : ColorsManager.white,
            BlendMode.srcIn,
          ),
        ),
    );
  }
}
