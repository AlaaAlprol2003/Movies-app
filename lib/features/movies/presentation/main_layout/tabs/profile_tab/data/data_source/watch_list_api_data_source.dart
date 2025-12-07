import 'package:dio/dio.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/watch_list_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Watch_list_response.dart';

import '../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../../core/resources/const_manager.dart';

class WatchListApiDataSource implements WatchListDataSource{
  Dio dio = Dio(BaseOptions(baseUrl: ProfileApiConstant.baseUrl));
  @override
  Future<void> addMovieToWatchList({required String movieId, required String token})async {
   try {
      final response = await dio.post(
        ProfileApiConstant.addToWatchListEndPoint, data: {
        "movieId": movieId,
      }, options: Options(headers: {
        "Authorization": "Bearer $token",
      },),);
    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to add");
   }

  }

  @override
  Future<WatchListResponse> getWatchListMovies({ required String token}) async{
    try {
      final response = await dio.get(
        ProfileApiConstant.getWatchListMoviesEndPoint, options: Options(headers: {
        "Authorization": "Bearer $token",
      },),);
      return WatchListResponse.fromJson(response.data);
    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to get");
    }
  }
}