import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/assets_manager.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    loadProfile();
  }

  void loadProfile() {
    emit(ProfileLoaded(
      name: 'John Safwat',
      phone: '01200000000',
      avatar: ImagesAssets.avatar8,
    ));
  }

  void updateProfile({String? name, String? phone, String? avatar}) {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoaded(
        name: name ?? currentState.name,
        phone: phone ?? currentState.phone,
        avatar: avatar ?? currentState.avatar,
      ));
    } else {
      emit(ProfileLoaded(
        name: name ?? 'John Safwat',
        phone: phone ?? '01200000000',
        avatar: avatar ?? ImagesAssets.avatar8,
      ));
    }
  }
}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String phone;
  final String avatar;

  ProfileLoaded({
    required this.name,
    required this.phone,
    required this.avatar,
  });
}
