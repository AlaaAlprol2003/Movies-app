import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/profile_cubit.dart';
import 'package:provider/provider.dart';
import 'config/lang_provider.dart';
import 'config/lang_shared_prefs.dart';
import 'config/theme_manager.dart';
import 'core/resources/routes_manager.dart';
import 'features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/movies/presentation/main_layout/tabs/profile_tab/data/models/movie_hive.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await LangSharedPrefs.init();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieHiveAdapter());
  await Hive.openBox<MovieHive>('historyBox');

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        BlocProvider(create: (_) => serviceLocator.get<AuthCubit>()),
        BlocProvider(create: (_) => serviceLocator.get<ProfileCubit>()),
        ChangeNotifierProvider(create: (_) => LangProvider()),
      ],
      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LangProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.generateRoute,
        initialRoute: RoutesManager.splashScreen,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(langProvider.currentLang),
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
