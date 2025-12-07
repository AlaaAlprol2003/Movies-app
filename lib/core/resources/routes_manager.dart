import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/presentation/movie_details/cubit/is_watch_list_cubit.dart';
import 'package:movies_app/features/movies/presentation/movie_details/cubit/movie_suggestions_cubit.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/auth/presentation/screens/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/movies/domain/use_cases/movie_details_use_case.dart';
import '../../features/movies/domain/use_cases/movie_suggestions_use_case.dart';
import '../../features/movies/presentation/main_layout/main_layout.dart';
import '../../features/movies/presentation/main_layout/main_layout_provider.dart';
import '../../features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/add_watch_list_use_case.dart';
import '../../features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/delete_movie_from__watch_list_use_case.dart';
import '../../features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/is_add_to_watch_list_use_case.dart';
import '../../features/movies/presentation/movie_details/cubit/movie_details_cubit.dart';
import '../../features/movies/presentation/movie_details/movie_details.dart';
import '../di/service_locator.dart';

class RoutesManager {
  static const String login = "login";
  static const String register = "register";
  static const String forgetPassword = "forgetPassword";
  static const String mainLayout = "mainLayout";
  static const String movieDetails = "movieDetails";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: LoginScreen(),
          ),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: RegisterScreen(),
          ),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
        );
      case mainLayout:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => MainLayoutProvider(),
            child: MainLayout(),
          ),
        );
      case movieDetails:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MovieDetailsCubit>(
                create: (_) => MovieDetailsCubit(
                  movieDetailsUseCase: serviceLocator.get<MovieDetailsUseCase>(),
                )..fetchMovie(movieId: movieId),
              ),
              BlocProvider<MovieSuggestionsCubit>(
                create: (_) => MovieSuggestionsCubit(
                  movieSuggestionsUseCase: serviceLocator.get<MovieSuggestionsUseCase>(),
                )..fetchMovies(movieId: movieId),
              ),
              BlocProvider<IsWatchListCubit>(
                create: (_) => IsWatchListCubit(
                  deleteWatchListUseCase: serviceLocator.get<DeleteWatchListUseCase>(),
                  addWatchListUseCase: serviceLocator.get<AddWatchListUseCase>(),
                  isAddToWatchListUseCase: serviceLocator.get<IsAddToWatchListUseCase>(),
                  movieId: movieId.toString(),
                )..checkIfAdded(),
              ),
            ],
            child: MovieDetails(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
