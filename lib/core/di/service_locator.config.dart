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
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;

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
    gh.singleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i432.AuthRemoteDataSource>(),
        authLocalDataSource: gh<_i485.AuthLocalDataSource>(),
      ),
    );
    gh.singleton<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.singleton<_i117.AuthCubit>(
      () => _i117.AuthCubit(registerUseCase: gh<_i1010.RegisterUseCase>()),
    );
    return this;
  }
}
