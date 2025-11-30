import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/auth/login/login_screen.dart';

import '../../models/onboarding_models.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<OnboardingModel> _onboardings;

  @override
  void initState() {
    super.initState();
    _onboardings = [
      OnboardingModel(
        imageAsset: AssetsManager.image1,
        title: 'Find Your Next Favorite Movie Here',
        subtitle: 'Get access to a huge library of movies \n to suit all tastes. You will surely like it.',
        buttonText: 'Explore Now',
      ),
      OnboardingModel(
        imageAsset: AssetsManager.image2,
        title: 'Discover Movies',
        subtitle: 'Explore a vast collection of movies in all \n qualities and genres. Find your next \n favorite film with ease.',
        buttonText: 'Next',
      ),
      OnboardingModel(
        imageAsset: AssetsManager.image3,
        title: 'Explore All Genres',
        subtitle: 'Discover movies from every genre, in all \n available qualities. Find something new \n and exciting to watch every day.',
        buttonText: 'Next',
      ),
      OnboardingModel(
        imageAsset: AssetsManager.image4,
        title: 'Create Watchlists',
        subtitle: 'Save movies to your watchlist to keep \n track of what you want to watch next.\n Enjoy films in various qualities and \n genres.',
        buttonText: 'Next',
      ),
      OnboardingModel(
        imageAsset: AssetsManager.image5,
        title: 'Rate, Review, and Learn',
        subtitle: 'Share your thoughts on the movies \n you ve watched. Dive deep into film \n details and help others discover great \n movies with your reviews.',
        buttonText: 'Next',
      ),
      OnboardingModel(
        imageAsset: AssetsManager.image6,
        title: 'Start Watching Now',
        subtitle: '',
        buttonText: 'Finish',
      ),
    ];
  }

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
            itemCount: _onboardings.length,
            itemBuilder: (context, index) {
              final isFirstPage = index == 0;
              final isLastPage = index == _onboardings.length - 1;
              final showBack = index > 1;

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _onboardings[index].imageAsset,
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
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.9),
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
                            _onboardings[index].title,
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
                            _onboardings[index].subtitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.5.h,
                            ),
                            textAlign: TextAlign.center,
                          ),
                           SizedBox(height: 24.h),
                          if (_onboardings.length > 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _onboardings.length,
                                    (idx) => Container(
                                  margin:  REdgeInsets.symmetric(horizontal: 4),
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPage == idx
                                        ?  ColorsManager.yellow
                                        : ColorsManager.white.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                           SizedBox(height: 24.h),
                          isFirstPage
                              ? _buildFirstPageButton()
                              : _buildNavigationButtons(showBack, isLastPage, index),
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

  Widget _buildFirstPageButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.yellow,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child:  Text(
          'Explore Now',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(bool showBack, bool isLastPage, int index) {
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
                _pageController.nextPage(
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
              _onboardings[index].buttonText,
              style:  TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
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
                _pageController.previousPage(
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
              child:  Text(
                'Back',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}