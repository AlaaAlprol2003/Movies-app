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
import 'package:movies_app/features/movies/data/data_sources/movies_api_data_source.dart'
    as _i182;
import 'package:movies_app/features/movies/data/data_sources/movies_data_source.dart'
    as _i649;
import 'package:movies_app/features/movies/data/repos_impl/movies_repo_impl.dart'
    as _i281;
import 'package:movies_app/features/movies/domain/repos/movies_repo.dart'
    as _i463;
import 'package:movies_app/features/movies/domain/use_cases/browse_use_case.dart'
    as _i803;
import 'package:movies_app/features/movies/domain/use_cases/carousel_movies_use_case.dart'
    as _i851;
import 'package:movies_app/features/movies/domain/use_cases/home_tab_categorise_use_case.dart'
    as _i92;
import 'package:movies_app/features/movies/domain/use_cases/search_use_case.dart'
    as _i584;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart'
    as _i747;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_carousel_cubit.dart'
    as _i432;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/home_tab/presentation/cubits/home_tab_category_cubit.dart'
    as _i859;
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart'
    as _i830;

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
    gh.singleton<_i656.AuthRemoteDataSource>(
      () => _i267.AuthApiRemoteDataSource(),
    );
    gh.lazySingleton<_i649.MoviesDataSource>(() => _i182.MoviesApiDataSource());
    gh.lazySingleton<_i463.MoviesRepo>(
      () => _i281.MoviesRepoImpl(dataSource: gh<_i649.MoviesDataSource>()),
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
    gh.factory<_i859.HomeTabCategoryCubit>(
      () => _i859.HomeTabCategoryCubit(
        homeTabCategoriseUseCase: gh<_i92.HomeTabCategoriseUseCase>(),
      ),
    );
    gh.lazySingleton<_i432.HomeTabCarouselCubit>(
      () => _i432.HomeTabCarouselCubit(
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
    gh.singleton<_i57.LoginUseCase>(
      () => _i57.LoginUseCase(authRepository: gh<_i88.AuthRepository>()),
    );
    gh.singleton<_i1019.RegisterUseCase>(
      () => _i1019.RegisterUseCase(authRepository: gh<_i88.AuthRepository>()),
    );
    gh.factory<_i747.BrowseCubit>(
      () => _i747.BrowseCubit(browseUseCase: gh<_i803.BrowseUseCase>()),
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
