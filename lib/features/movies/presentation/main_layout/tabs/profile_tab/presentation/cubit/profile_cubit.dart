import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/edit_profile_response.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/entities/user_profile_entity.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/repo/profile_repo.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/delete_profile_use_case.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/domain/use_cases/profile_use_case.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.profileUseCase,
    required this.profileRepo,
    required this.deleteProfileUseCase,
  }) : super(ProfileInitial());
  ProfileRepo profileRepo;
  ProfileUseCase profileUseCase;
  DeleteProfileUseCase deleteProfileUseCase;


  Future<void> getUser() async {
    emit(ProfileLoading());
    try {
      final response = await profileUseCase();
      response.fold(
        (failure) => emit(ProfileOnError(message: failure.message)),
        (user) => emit(ProfileOnSuccess(user: user)),
      );
    } catch (e) {
      emit(ProfileOnError(message: e.toString()));
    }
  }

 Future<void> editProfile(
    String email,
    int avatarId,
    String name,
    String phone,
  ) async {
    emit(EditProfileLoading());
    try {
      final response = await profileRepo.editProfile(
        email,
        avatarId,
        name,
        phone,
      );
      response.fold(
        (failure) {
          emit(EditProfileError(message: failure.message));
        },
        (response) {

          emit(EditProfileSuccess(response: response));
        },
      );
    } catch (ex) {
      emit(EditProfileError(message: ex.toString()));
    }
  }

  Future<void> deleteProfile() async {
    emit(DeleteProfileLoading());
    try {
      final response = await deleteProfileUseCase();
      response.fold(
        (failure) {
          emit(DeleteProfileError(message: failure.message));
        },
        (_) {
          emit(DeleteProfileSuccess());
          emit(UserDeleted());
        },
      );
    } catch (ex) {
      emit(DeleteProfileError(message: ex.toString()));
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
  ProfileOnSuccess({required this.user});
}

class EditProfileLoading extends ProfileState {}

class EditProfileError extends ProfileState {
  String message;
  EditProfileError({required this.message});
}

class EditProfileSuccess extends ProfileState {
  EditProfileResponse response;
  EditProfileSuccess({required this.response});
}

class DeleteProfileLoading extends ProfileState {}

class DeleteProfileError extends ProfileState {
  String message;
  DeleteProfileError({required this.message});
}

class DeleteProfileSuccess extends ProfileState {}
class UserDeleted extends ProfileState {}