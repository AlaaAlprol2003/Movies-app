import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/cast_container.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/custom_container.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/genres_display.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/movie_gradient.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/screen_shots_display.dart';
import 'package:movies_app/features/movies/presentation/movie_details/widgets/similar_display.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/ui_utils.dart';
import 'cubit/cubit_states.dart';
import 'cubit/movie_details_cubit.dart';
import 'cubit/movie_suggestions_cubit.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.white,
            size: 32.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: ColorsManager.white,
              size: 32.sp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MovieDetailsOnError) {
            return Padding(
              padding: REdgeInsets.symmetric(vertical: 300),
              child: Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: ColorsManager.red),
                ),
              ),
            );
          }
          if (state is MovieDetailsOnSuccess) {
            final movie = state.movie;
            return SingleChildScrollView(
              padding: REdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 680.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        MovieGradient(
                          pic: movie.mediumCoverImage,
                          movieTitle: movie.title,
                          movieYear: movie.year.toString(),
                        ),
                        InkWell(
                          onTap: () {
                            openUrl(movie.url,context);
                          },
                          child: SvgPicture.asset(IconAssets.play),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomElevatedButton(
                          text: "Watch",
                          onPress: () {
                            openUrl(movie.url,context);
                          },
                          color: ColorsManager.red,
                          textColor: ColorsManager.white,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            CustomContainer(
                              text: movie.runtime.toString(),
                              icon: IconAssets.clock,
                            ),
                            SizedBox(width: 10.w),
                            CustomContainer(
                              text: movie.likeCount.toString(),
                              icon: IconAssets.heart,
                            ),
                            SizedBox(width: 10.w),
                            CustomContainer(
                              text: movie.rating.toString(),
                              icon: IconAssets.star,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Screen Shots",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Visibility(
                          visible: movie.mediumScreenshotImage1.isNotEmpty,
                          child: ScreenShotsDisplay(
                            screenShot: movie.mediumScreenshotImage1,
                          ),
                        ),
                        Visibility(
                          visible: movie.mediumScreenshotImage1 == '' && movie.mediumScreenshotImage2=='' && movie.mediumScreenshotImage3=='',
                          child: Text(
                            "No Screen Shots Available",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Visibility(
                          visible: movie.mediumScreenshotImage2.isNotEmpty,
                          child: ScreenShotsDisplay(
                            screenShot: movie.mediumScreenshotImage2,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Visibility(
                          visible: movie.mediumScreenshotImage3.isNotEmpty,
                          child: ScreenShotsDisplay(
                            screenShot: movie.mediumScreenshotImage3,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Similar",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<MovieSuggestionsCubit, MovieSuggestionsState>(
                          builder: (context, state) {
                            if (state is MovieSuggestionsLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is MovieSuggestionsOnError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: TextStyle(color: ColorsManager.red),
                                ),
                              );
                            }
                            if (state is MovieSuggestionsOnSuccess) {
                              final movies = state.movies;
                              return movies.isEmpty? Text(
                                "No Similar Movies Found",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsManager.white,
                                ),
                              ): SimilarDisplay(movies: movies);
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Summary",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          movie.descriptionFull.trim().isEmpty
                              ? "No Summary Available"
                              : movie.descriptionFull,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Cast",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            movie.cast?.length ?? 0,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: CastContainer(cast: movie.cast![index]),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: movie.cast?.isEmpty == true ? true : false,
                          child: Text(
                            "No Cast Available",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Genres",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GenresDisplay(genre: movie.genres),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
  Future<void> openUrl(String url,BuildContext context) async {
    final uri = Uri.tryParse(url);
    if(uri == null || url.isEmpty){
    return UiUtils.showToastNotificationBar(context, "Movie Link Not Found", ColorsManager.white, ColorsManager.red, Icons.error);
    }
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

}
