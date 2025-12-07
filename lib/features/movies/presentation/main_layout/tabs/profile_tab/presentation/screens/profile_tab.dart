import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/auth/presentation/screens/login_screen.dart';
import '../../../../../../../../core/models/avatar.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/watchlist_cubit.dart';
import 'edit_profile_screen.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/movie_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});


  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<WatchListCubit>().getWatchList();
  }



  @override
  Widget build(BuildContext context) {

         return Scaffold(
            backgroundColor: ColorsManager.black,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.all(30),
                    child:BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }else if (state is ProfileOnError) {
                          return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
                        }else if (state is ProfileOnSuccess) {
                          final user = state.user;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40.r,
                                    child: ClipOval(
                                      child: Image.asset(
                                        Avatar.avatars[user.avaterId].bath,
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                            stackTrace) {
                                          return Icon(
                                            Icons.person,
                                            size: 40.sp,
                                            color: Colors.white,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "12",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "Watch List",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "10",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "History",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  user.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 48.h,
                                      child: CustomElevatedButton(
                                        text: "Edit Profile",
                                        onPress: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen(
                                                    currentName: user.name,
                                                    currentPhone: user.phone,
                                                    currentAvatar: Avatar
                                                        .avatars[user.avaterId]
                                                        .bath,
                                                  ),
                                            ),
                                          );

                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 48.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showLogoutDialog(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorsManager.red,
                                          foregroundColor: ColorsManager.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              'Exit',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Icon(
                                              Icons.logout,
                                              size: 18.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }else{
                          return SizedBox();
                        }
                      }
                    ),
                  ),
                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorsManager.grey.withValues(alpha: .2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: TabBar(
                        indicatorColor: ColorsManager.yellow,
                        indicatorWeight: 3,
                        labelColor: ColorsManager.yellow,
                        unselectedLabelColor: ColorsManager.grey,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.list_alt, size: 24.sp),
                            text: 'Watch List',
                          ),
                          Tab(
                            icon: Icon(Icons.folder, size: 24.sp),
                            text: 'History',
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Tab Bar view
                  Expanded(
                    child: TabBarView(
                      controller: tabController,

                      children: [
                        // WatchList Tab
                        BlocBuilder<WatchListCubit, WatchListState>(
                          builder: (context, state) {
                            if (state is WatchListLoading) {
                              return const Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
                            } else if (state is WatchListError) {
                              return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
                            } else if (state is WatchListSuccess) {
                              final movies = state.movies;
                              if (movies.isEmpty) {
                                return _buildEmptyState(ImagesAssets.empity, 'Your watchlist is empty');
                              }
                              return GridView.builder(
                                padding: REdgeInsets.all(16),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  return MovieItem(
                                    movie: movies[index],
                                  );
                                },
                              );
                            }else{
                              return SizedBox();
                            }

                          },
                        ),
                        BlocBuilder<WatchListCubit, WatchListState>(
                          builder: (context, state) {
                            if (state is WatchListLoading) {
                              return const Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
                            } else if (state is WatchListError) {
                              return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
                            } else if (state is WatchListSuccess) {
                              final movies = state.movies;
                              if (movies.isEmpty) {
                                return _buildEmptyState(ImagesAssets.empity, 'Your watchlist is empty');
                              }
                              return GridView.builder(
                                padding: REdgeInsets.all(16),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  return MovieItem(
                                   movie: movies[index],
                                  );
                                },
                              );
                            }else{
                              return SizedBox();
                            }

                          },
                        ),
                        // History Tab
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }



  Widget _buildEmptyState(String imagePath, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150.w,
            height: 150.h,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.movie_outlined,
                size: 100.sp,
                color: ColorsManager.yellow,
              );
            },
          ),
          SizedBox(height: 20.h),
          Text(
            message,
            style: TextStyle(
              color: ColorsManager.grey,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsManager.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}