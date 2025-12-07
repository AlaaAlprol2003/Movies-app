import 'package:injectable/injectable.dart';
import 'package:movies_app/core/resources/const_manager.dart';
import 'package:movies_app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
@Singleton(as:AuthLocalDataSource )
class AuthSharedPrefsLocalDataSource implements AuthLocalDataSource {
  @override
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthLocalConstant.tokenKey)!;
  }

  @override
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AuthLocalConstant.tokenKey, token);
  }
  @override
  Future<void> deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(AuthLocalConstant.tokenKey);
}
}
