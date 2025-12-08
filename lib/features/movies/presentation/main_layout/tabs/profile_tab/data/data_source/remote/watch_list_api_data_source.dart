import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/data_source/remote/watch_list_data_source.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/data/models/Watch_list_response.dart';

import '../../../../../../../../../core/errors/errors/app_exceptions.dart';
import '../../../../../../../../../core/resources/const_manager.dart';
import '../../models/Is_added_to_watch_list.dart';
import '../../models/watch_list_request.dart';
@LazySingleton(as: WatchListDataSource)
class WatchListApiDataSource implements WatchListDataSource{
  Dio dio = Dio(BaseOptions(baseUrl: ProfileApiConstant.baseUrl));
  @override
  Future<void> addMovieToWatchList({required WatchListRequest request, required String token})async {
   try {
      await dio.post(
        ProfileApiConstant.addToWatchListEndPoint, data: request.toJson(), options: Options(headers: {
        "Authorization": "Bearer $token",
      },),);
    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
        print(message);
      }
      throw RemoteException(message: message ?? "Failed to add");
   }

  }

  @override
  Future<WatchListResponse> getWatchListMovies({ required String token}) async{
    try {
      Response response = await dio.get(
        ProfileApiConstant.getWatchListMoviesEndPoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return WatchListResponse.fromJson(response.data);
    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to get");
    }
  }

  @override
  Future<void> deleteMovieFromWatchList({required String token, required String movieId}) async{
    try {
      await dio.delete(
        ProfileApiConstant.deleteFromWatchListEndPoint+movieId, options: Options(headers: {
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
  Future<IsAddedToWatchList> isAddedToWatchList({required String token, required String movieId}) async{
    try {
    final response =  await dio.get(
        ProfileApiConstant.isAddedToWatchListEndPoint+movieId, options: Options(headers: {
        "Authorization": "Bearer $token",
      },),);
    return IsAddedToWatchList.fromJson(response.data);
    }catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to add");
    }
  }

}