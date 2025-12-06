import 'package:injectable/injectable.dart';

import '../models/Profile_response.dart';

@lazySingleton
abstract class ProfileDataSource {

  Future< ProfileResponse> getProfile(
      String token,
      );
}