import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:toastification/toastification.dart';

class UiUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(color: ColorsManager.yellow),
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showToastificationBar(
    BuildContext context,
    String message,
    Color fgColor,
    Color bgColor,
    IconData icon,
  ) {
    toastification.show(
      context: context,
      description: Text(message),
      foregroundColor: fgColor,
      backgroundColor: bgColor,
      borderRadius: BorderRadius.circular(16),
      icon: Icon(icon, color: ColorsManager.white),
      borderSide: BorderSide(color: ColorsManager.yellow, width: 2.w),
 
      autoCloseDuration: Duration(seconds:7),
    );
  }
}
