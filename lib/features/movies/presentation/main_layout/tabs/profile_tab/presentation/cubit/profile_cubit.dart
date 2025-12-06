import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/features/auth/domain/entities/user_entity.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/entities/user_profile_entity.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/profile_use_case.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
      {
        required this.profileUseCase}
      ) : super(ProfileInitial());

  ProfileUseCase profileUseCase;


  void getUser() async{
    emit(ProfileLoading());
    try {
    final response = await profileUseCase();
    response.fold(
        (failure) => emit(ProfileOnError(message: failure.message))
        , (user) => emit(ProfileOnSuccess(user: user))
    );
      }catch(e){
      emit(ProfileOnError(message: e.toString()));
    }
  }

}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileOnError extends ProfileState {
  String message;
  ProfileOnError({required this.message});
}

class ProfileOnSuccess extends ProfileState {
  UserProfileEntity user;
  ProfileOnSuccess({
    required this.user,
  });
}
