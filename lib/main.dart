import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import 'package:movies_app/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart';
import 'package:movies_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'config/theme_manager.dart';
import 'core/resources/routes_manager.dart';

void main() {
  configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => serviceLocator<AuthCubit>(),
      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RoutesManager.routes,
        initialRoute: RoutesManager.login,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
