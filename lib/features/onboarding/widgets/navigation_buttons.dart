import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/onboarding_models.dart';
import '../../../core/resources/colors_manager.dart';
import '../../auth/login/login_screen.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    super.key,
    required this.showBack,
    required this.isLastPage,
    required this.index,
    required this.pageController,
  });

  final bool showBack;
  final bool isLastPage;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              if (isLastPage) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.yellow,
              foregroundColor: ColorsManager.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              OnboardingModel.onboardings[index].buttonText,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        if (showBack) ...[
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorsManager.white,
                side: BorderSide(color: Colors.yellow, width: 3.w),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
