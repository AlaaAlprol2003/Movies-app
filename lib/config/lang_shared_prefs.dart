import 'package:shared_preferences/shared_preferences.dart';

class LangSharedPrefs {
 static late SharedPreferences prefs;

 static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

static  void saveLang(String lang) {
    prefs.setString("lang_key", lang);
  }

 static String getSavedLang() {
    String savedLang = prefs.getString("lang_key") ?? "en";
    return savedLang;
  }
}
