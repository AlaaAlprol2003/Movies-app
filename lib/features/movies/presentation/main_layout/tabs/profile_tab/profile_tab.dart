import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/auth/presentation/screens/login_screen.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/watchlist_cubit.dart';
import 'cubit/history_cubit.dart';
import 'edit_profile_screen.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/movie_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Trigger initial data fetch
    context.read<WatchListCubit>().getWatchList();
    context.read<HistoryCubit>().getHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String userName = 'John Safwat';
        String userPhone = '01200000000';
        String userAvatar = ImagesAssets.avatar8;

        if (state is ProfileLoaded) {
          userName = state.name;
          userPhone = state.phone;
          userAvatar = state.avatar;
        }

        return Scaffold(
          backgroundColor: ColorsManager.black,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            child: ClipOval(
                              child: Image.asset(
                                userAvatar,
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          userName,
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
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                        currentName: userName,
                                        currentPhone: userPhone,
                                        currentAvatar: userAvatar,
                                      ),
                                    ),
                                  );

                                  if (result != null && result is Map<String, dynamic>) {
                                    context.read<ProfileCubit>().updateProfile(
                                      name: result['name'],
                                      phone: result['phone'],
                                      avatar: result['avatar'],
                                    );
                                  }
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
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
                // Tab Bar
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColorsManager.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
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
                //Tab Bar view
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // WatchList Tab
                      BlocBuilder<WatchListCubit, WatchListState>(
                        builder: (context, state) {
                          if (state is WatchListLoading) {
                            return const Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
                          } else if (state is WatchListError) {
                            return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
                          } else if (state is WatchListSuccess) {
                            if (state.movies.isEmpty) {
                              return _buildEmptyState(ImagesAssets.empity, 'Your watchlist is empty');
                            }
                            return GridView.builder(
                              padding: REdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                return MovieItem(
                                  pic: state.movies[index].mediumCoverImage ?? '',
                                  rate: state.movies[index].rating ?? 0.0,
                                );
                              },
                            );
                          }
                          return _buildEmptyState(ImagesAssets.empity, 'Your watchlist is empty');
                        },
                      ),
                      // History Tab
                      BlocBuilder<HistoryCubit, HistoryState>(
                        builder: (context, state) {
                          if (state is HistoryLoading) {
                            return const Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
                          } else if (state is HistoryError) {
                            return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
                          } else if (state is HistorySuccess) {
                            if (state.movies.isEmpty) {
                              return _buildEmptyState(ImagesAssets.empity, 'No viewing history yet');
                            }
                            return GridView.builder(
                              padding: REdgeInsets.all(16),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                return MovieItem(
                                  pic: state.movies[index].mediumCoverImage ?? '',
                                  rate: state.movies[index].rating ?? 0.0,
                                );
                              },
                            );
                          }
                          return _buildEmptyState(ImagesAssets.empity, 'No viewing history yet');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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