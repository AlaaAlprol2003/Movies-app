// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies_app/features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i922;
import 'package:movies_app/features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart'
    as _i825;
import 'package:movies_app/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart'
    as _i267;
import 'package:movies_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i656;
import 'package:movies_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i95;
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart'
    as _i88;
import 'package:movies_app/features/auth/domain/use_cases/login_use_case.dart'
    as _i57;
import 'package:movies_app/features/auth/domain/use_cases/register_use_case.dart'
    as _i1019;
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i489;
import 'package:movies_app/features/movies/data/data_sources/movie_details_data_source/movie_details_api_data_source.dart'
    as _i206;
import 'package:movies_app/features/movies/data/data_sources/movie_details_data_source/movie_details_data_source.dart'
    as _i463;
import 'package:movies_app/features/movies/data/data_sources/movie_suggestions_data_source/movie_suggestions_api_data_source.dart'
    as _i784;
import 'package:movies_app/features/movies/data/data_sources/movie_suggestions_data_source/movie_suggestions_data_source.dart'
    as _i198;
import 'package:movies_app/features/movies/data/data_sources/movies_data_source/movies_api_data_source.dart'
    as _i769;
import 'package:movies_app/features/movies/data/data_sources/movies_data_source/movies_data_source.dart'
    as _i812;
import 'package:movies_app/features/movies/data/repos_impl/movie_details_repo_impl.dart'
    as _i904;
import 'package:movies_app/features/movies/data/repos_impl/movie_suggestions_repo_impl.dart'
    as _i645;
import 'package:movies_app/features/movies/data/repos_impl/movies_repo_impl.dart'
    as _i281;
import 'package:movies_app/features/movies/domain/repos/movie_details_repo.dart'
    as _i173;
import 'package:movies_app/features/movies/domain/repos/movie_suggestions_repo.dart'
    as _i287;
import 'package:movies_app/features/movies/domain/repos/movies_repo.dart'
    as _i463;
import 'package:movies_app/features/movies/domain/use_cases/browse_use_case.dart'
    as _i803;
import 'package:movies_app/features/movies/domain/use_cases/carousel_movies_use_case.dart'
    as _i851;
import 'package:movies_app/features/movies/domain/use_cases/home_tab_categorise_use_case.dart'
    as _i92;
import 'package:movies_app/features/movies/domain/use_cases/movie_details_use_case.dart'
    as _i7;
import 'package:movies_app/features/movies/domain/use_cases/movie_suggestions_use_case.dart'
    as _i0;
import 'package:movies_app/features/movies/domain/use_cases/search_use_case.dart'
    as _i584;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart'
    as _i747;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/cubits/home_tab_carousel_cubit.dart'
    as _i774;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/cubits/home_tab_category_cubit.dart'
    as _i408;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/profile_api_data_source.dart'
    as _i193;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/profile_data_source.dart'
    as _i70;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/watch_list_api_data_source.dart'
    as _i1040;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/watch_list_data_source.dart'
    as _i817;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/repo_mpl/profile_repo_impl.dart'
    as _i562;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/repo_mpl/watch_list_repo_impl.dart'
    as _i307;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/profile_repo.dart'
    as _i173;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/watch_list_repo.dart'
    as _i299;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/add_watch_list_use_case.dart'
    as _i882;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/delete_movie_from__watch_list_use_case.dart'
    as _i401;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/get_watch_list_movies_use_case.dart'
    as _i68;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/is_add_to_watch_list_use_case.dart'
    as _i451;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/profile_use_case.dart'
    as _i384;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/history_cubit.dart'
    as _i978;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/profile_cubit.dart'
    as _i142;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/watchlist_cubit.dart'
    as _i636;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart'
    as _i830;
import 'package:movies_app/features/movies/presentation/movie_details/cubit/is_watch_list_cubit.dart'
    as _i906;
import 'package:movies_app/features/movies/presentation/movie_details/cubit/movie_details_cubit.dart'
    as _i590;
import 'package:movies_app/features/movies/presentation/movie_details/cubit/movie_suggestions_cubit.dart'
    as _i582;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i922.AuthLocalDataSource>(
      () => _i825.AuthSharedPrefsLocalDataSource(),
    );
    gh.factory<_i978.HistoryCubit>(
      () => _i978.HistoryCubit(gh<_i978.HistoryState>()),
    );
    gh.singleton<_i198.MovieSuggestionsDataSource>(
      () => _i784.MovieSuggestionsApiDataSource(),
    );
    gh.lazySingleton<_i70.ProfileDataSource>(
      () => _i193.ProfileApiDataSource(),
    );
    gh.lazySingleton<_i817.WatchListDataSource>(
      () => _i1040.WatchListApiDataSource(),
    );
    gh.singleton<_i812.MoviesDataSource>(() => _i769.MoviesApiDataSource());
    gh.singleton<_i463.MovieDetailsDataSource>(
      () => _i206.MovieDetailsApiDataSource(),
    );
    gh.lazySingleton<_i173.ProfileRepo>(
      () => _i562.ProfileRepoImpl(
        profileDataSource: gh<_i70.ProfileDataSource>(),
      ),
    );
    gh.singleton<_i656.AuthRemoteDataSource>(
      () => _i267.AuthApiRemoteDataSource(),
    );
    gh.lazySingleton<_i384.ProfileUseCase>(
      () => _i384.ProfileUseCase(profileRepo: gh<_i173.ProfileRepo>()),
    );
    gh.singleton<_i173.MovieDetailsRepo>(
      () => _i904.MoviesDetailsRepoImpl(
        dataSource: gh<_i463.MovieDetailsDataSource>(),
      ),
    );
    gh.lazySingleton<_i7.MovieDetailsUseCase>(
      () => _i7.MovieDetailsUseCase(gh<_i173.MovieDetailsRepo>()),
    );
    gh.singleton<_i463.MoviesRepo>(
      () => _i281.MoviesRepoImpl(dataSource: gh<_i812.MoviesDataSource>()),
    );
    gh.lazySingleton<_i803.BrowseUseCase>(
      () => _i803.BrowseUseCase(moviesRepo: gh<_i463.MoviesRepo>()),
    );
    gh.lazySingleton<_i851.CarouselMoviesUseCase>(
      () => _i851.CarouselMoviesUseCase(moviesRepo: gh<_i463.MoviesRepo>()),
    );
    gh.lazySingleton<_i584.SearchUseCase>(
      () => _i584.SearchUseCase(moviesRepo: gh<_i463.MoviesRepo>()),
    );
    gh.factory<_i92.HomeTabCategoriseUseCase>(
      () => _i92.HomeTabCategoriseUseCase(moviesRepo: gh<_i463.MoviesRepo>()),
    );
    gh.singleton<_i287.MovieSuggestionsRepo>(
      () => _i645.MovieSuggestionsRepoImpl(
        dataSource: gh<_i198.MovieSuggestionsDataSource>(),
      ),
    );
    gh.factory<_i408.HomeTabCategoryCubit>(
      () => _i408.HomeTabCategoryCubit(
        homeTabCategoriseUseCase: gh<_i92.HomeTabCategoriseUseCase>(),
      ),
    );
    gh.lazySingleton<_i774.HomeTabCarouselCubit>(
      () => _i774.HomeTabCarouselCubit(
        carouselMoviesUseCase: gh<_i851.CarouselMoviesUseCase>(),
      ),
    );
    gh.singleton<_i88.AuthRepository>(
      () => _i95.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i656.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i922.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i830.SearchCubit>(
      () => _i830.SearchCubit(searchUseCase: gh<_i584.SearchUseCase>()),
    );
    gh.lazySingleton<_i142.ProfileCubit>(
      () => _i142.ProfileCubit(profileUseCase: gh<_i384.ProfileUseCase>()),
    );
    gh.lazySingleton<_i299.WatchListRepo>(
      () => _i307.WatchListRepoImpl(
        watchListDataSource: gh<_i817.WatchListDataSource>(),
      ),
    );
    gh.lazySingleton<_i0.MovieSuggestionsUseCase>(
      () => _i0.MovieSuggestionsUseCase(
        movieSuggestionsRepo: gh<_i287.MovieSuggestionsRepo>(),
      ),
    );
    gh.lazySingleton<_i590.MovieDetailsCubit>(
      () => _i590.MovieDetailsCubit(
        movieDetailsUseCase: gh<_i7.MovieDetailsUseCase>(),
      ),
    );
    gh.singleton<_i57.LoginUseCase>(
      () => _i57.LoginUseCase(authRepository: gh<_i88.AuthRepository>()),
    );
    gh.singleton<_i1019.RegisterUseCase>(
      () => _i1019.RegisterUseCase(authRepository: gh<_i88.AuthRepository>()),
    );
    gh.factory<_i747.BrowseCubit>(
      () => _i747.BrowseCubit(browseUseCase: gh<_i803.BrowseUseCase>()),
    );
    gh.lazySingleton<_i582.MovieSuggestionsCubit>(
      () => _i582.MovieSuggestionsCubit(
        movieSuggestionsUseCase: gh<_i0.MovieSuggestionsUseCase>(),
      ),
    );
    gh.lazySingleton<_i882.AddWatchListUseCase>(
      () => _i882.AddWatchListUseCase(watchListRepo: gh<_i299.WatchListRepo>()),
    );
    gh.lazySingleton<_i401.DeleteWatchListUseCase>(
      () => _i401.DeleteWatchListUseCase(
        watchListRepo: gh<_i299.WatchListRepo>(),
      ),
    );
    gh.lazySingleton<_i68.GetWatchListMoviesUseCase>(
      () => _i68.GetWatchListMoviesUseCase(
        watchListRepo: gh<_i299.WatchListRepo>(),
      ),
    );
    gh.lazySingleton<_i451.IsAddToWatchListUseCase>(
      () => _i451.IsAddToWatchListUseCase(
        watchListRepo: gh<_i299.WatchListRepo>(),
      ),
    );
    gh.lazySingleton<_i906.IsWatchListCubit>(
      () => _i906.IsWatchListCubit(
        deleteWatchListUseCase: gh<_i401.DeleteWatchListUseCase>(),
        addWatchListUseCase: gh<_i882.AddWatchListUseCase>(),
        isAddToWatchListUseCase: gh<_i451.IsAddToWatchListUseCase>(),
        movieId: gh<String>(),
      ),
    );
    gh.lazySingleton<_i636.WatchListCubit>(
      () => _i636.WatchListCubit(
        getWatchListMoviesUseCase: gh<_i68.GetWatchListMoviesUseCase>(),
      ),
    );
    gh.singleton<_i489.AuthCubit>(
      () => _i489.AuthCubit(
        registerUseCase: gh<_i1019.RegisterUseCase>(),
        loginUseCase: gh<_i57.LoginUseCase>(),
      ),
    );
    return this;
  }
}
