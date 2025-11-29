import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/errors/errors/app_exceptions.dart';
import 'package:movies_app/core/resources/const_manager.dart';
import 'package:movies_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movies_app/features/auth/data/models/register_request.dart';
import 'package:movies_app/features/auth/data/models/register_response.dart';
@Singleton(as:AuthRemoteDataSource)
class AuthApiRemoteDataSource implements AuthRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AuthApiConstant.baseUrl));
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        AuthApiConstant.registerEndPoint,
        data: request.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"].toString();
      }
      throw RemoteException(message: message ?? "Failed");
    }
  }
}
