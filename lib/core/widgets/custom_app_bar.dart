import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/value_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.titleText,required this.onIconPress});
  final String titleText;
  final VoidCallback onIconPress;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.h),
      child: AppBar(
        title: Text(titleText),
        leading: IconButton(onPressed: onIconPress, icon: Icon(Icons.arrow_back)),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, AppSize.s50.h);
}
