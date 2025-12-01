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

import '../../features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i485;
import '../../features/auth/data/data_sources/local/auth_shared_prefs_local_data_source.dart'
    as _i277;
import '../../features/auth/data/data_sources/remote/auth_api_remote_data_source.dart'
    as _i112;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/movies/data/data_sources/movies_api_data_source.dart'
    as _i363;
import '../../features/movies/data/data_sources/movies_data_source.dart'
    as _i754;
import '../../features/movies/data/repos_impl/movies_repo_impl.dart' as _i169;
import '../../features/movies/domain/repos/movies_repo.dart' as _i786;
import '../../features/movies/domain/use_cases/browse_use_case.dart' as _i883;
import '../../features/movies/domain/use_cases/carousel_movies_use_case.dart'
    as _i1050;
import '../../features/movies/domain/use_cases/search_use_case.dart' as _i605;
import '../../features/movies/presentation/main_layout/tabs/browse_tab/cubit/browse_cubit.dart'
    as _i138;
import '../../features/movies/presentation/main_layout/tabs/home_tab/presentation/home_tab_cubit.dart'
    as _i825;
import '../../features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart'
    as _i267;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i485.AuthLocalDataSource>(
      () => _i277.AuthSharedPrefsLocalDataSource(),
    );
    gh.singleton<_i432.AuthRemoteDataSource>(
      () => _i112.AuthApiRemoteDataSource(),
    );
    gh.lazySingleton<_i754.MoviesDataSource>(() => _i363.MoviesApiDataSource());
    gh.lazySingleton<_i786.MoviesRepo>(
      () => _i169.MoviesRepoImpl(dataSource: gh<_i754.MoviesDataSource>()),
    );
    gh.lazySingleton<_i883.BrowseUseCase>(
      () => _i883.BrowseUseCase(moviesRepo: gh<_i786.MoviesRepo>()),
    );
    gh.lazySingleton<_i1050.CarouselMoviesUseCase>(
      () => _i1050.CarouselMoviesUseCase(moviesRepo: gh<_i786.MoviesRepo>()),
    );
    gh.lazySingleton<_i605.SearchUseCase>(
      () => _i605.SearchUseCase(moviesRepo: gh<_i786.MoviesRepo>()),
    );
    gh.factory<_i825.HomeTabCubit>(
      () => _i825.HomeTabCubit(
        carouselMoviesUseCase: gh<_i1050.CarouselMoviesUseCase>(),
      ),
    );
    gh.singleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i432.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i485.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i267.SearchCubit>(
      () => _i267.SearchCubit(searchUseCase: gh<_i605.SearchUseCase>()),
    );
    gh.singleton<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.singleton<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i138.BrowseCubit>(
      () => _i138.BrowseCubit(browseUseCase: gh<_i883.BrowseUseCase>()),
    );
    gh.singleton<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        registerUseCase: gh<_i1010.RegisterUseCase>(),
        loginUseCase: gh<_i1038.LoginUseCase>(),
      ),
    );
    return this;
  }
}
