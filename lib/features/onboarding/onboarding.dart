import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/onboarding/widgets/first_page_button.dart';
import 'package:movies_app/features/onboarding/widgets/navigation_buttons.dart';
import '../../core/models/onboarding_models.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: OnboardingModel.onboardings.length,
            itemBuilder: (context, index) {
              final isFirstPage = index == 0;
              final isLastPage = index == OnboardingModel.onboardings.length - 1;
              final showBack = index > 1;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    OnboardingModel.onboardings[index].imageAsset,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          ColorsManager.black.withValues(alpha: .9),
                          ColorsManager.black.withValues(alpha: .9),
                        ],
                        stops: const [0.1, 0.7, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.black,
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      padding:  REdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            OnboardingModel.onboardings[index].title,
                            style:  TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.3.h,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            OnboardingModel.onboardings[index].subtitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorsManager.white.withValues(alpha: .7),
                              height: 1.5.h,
                            ),
                            textAlign: TextAlign.center,
                          ),
                           SizedBox(height: 24.h),
                          if (OnboardingModel.onboardings.length > 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                OnboardingModel.onboardings.length,
                                    (idx) => Container(
                                  margin:  REdgeInsets.symmetric(horizontal: 4),
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPage == idx
                                        ?  ColorsManager.yellow
                                        : ColorsManager.white.withValues(alpha: .3),
                                  ),
                                ),
                              ),
                            ),
                           SizedBox(height: 24.h),
                          isFirstPage
                              ? FirstPageButton(
                            pageController: _pageController,
                          )
                              : NavigationButtons(
                            showBack: showBack,
                            isLastPage: isLastPage,
                            index: index,
                            pageController: _pageController,

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }




}