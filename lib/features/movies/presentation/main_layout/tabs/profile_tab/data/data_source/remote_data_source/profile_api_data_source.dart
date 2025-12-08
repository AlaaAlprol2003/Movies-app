import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/remote_data_source/profile_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Profile_response.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/edit_profile_response.dart';
import '../../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../../../core/resources/const_manager.dart';

@LazySingleton(as: ProfileDataSource)
class ProfileApiDataSource implements ProfileDataSource {
  final Dio dio = Dio(BaseOptions(baseUrl: ProfileApiConstant.baseUrl));

  @override
  Future<ProfileResponse> getProfile(String token) async {
    try {
      Response response = await dio.get(
        ProfileApiConstant.getProfileEndPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return ProfileResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to login");
    }
  }

  @override
  Future<EditProfileResponse> editProfile(
    String token,
    String email,
    int avatarId,
    String name,
    String phone,
  ) async {
    try {
      Response response = await dio.patch(
        ProfileApiConstant.getProfileEndPoint,
        data: {
          "email": email,
          "avaterId": avatarId,
          "name": name,
          "phone": phone,
        },

        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return EditProfileResponse.fromJson(response.data);
    } catch (ex) {
      String? message;
      if (ex is DioException) {
        message = ex.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to edit profile");
    }
  }

  @override
  Future<void> deleteProfile(String token) async {
    try {
      await dio.delete(
        ProfileApiConstant.getProfileEndPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to login");
    }
  }
}
