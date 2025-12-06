import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/profile_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Profile_response.dart';
import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../../core/resources/const_manager.dart';

@LazySingleton(as: ProfileDataSource)
class ProfileApiDataSource implements ProfileDataSource {

  final Dio dio = Dio(BaseOptions(
    baseUrl: ProfileApiConstant.baseUrl,
  ));

  @override
  Future< ProfileResponse> getProfile(String token) async {
    try {
      Response response = await dio.get(
        ProfileApiConstant.getProfileEndPoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return ProfileResponse.fromJson(response.data);

    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to login");
    }
  }
}
