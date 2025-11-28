import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/value_manager.dart';

class ThemeManager {
  static final ThemeData light = ThemeData();
  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorsManager.black,
    appBarTheme: AppBarThemeData(
      backgroundColor: ColorsManager.black,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsManager.yellow),
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.yellow,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        minimumSize: Size(double.infinity, AppSize.s55),
        textStyle: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        foregroundColor: ColorsManager.black,
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      prefixIconColor: ColorsManager.white,
      suffixIconColor: ColorsManager.white,
      hintStyle: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
      filled: true,
      fillColor: ColorsManager.grey,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
    ),
  );
}
