import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/edit_profile_response.dart';

import '../models/Profile_response.dart';

@lazySingleton
abstract class ProfileDataSource {
  Future<ProfileResponse> getProfile(String token);
  
  Future<EditProfileResponse> editProfile(String token,String email, int avatarId,String name,String phone);
  Future<void> deleteProfile(String token);
}
