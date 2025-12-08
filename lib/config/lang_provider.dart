import 'package:flutter/material.dart';
import 'package:movies_app/config/lang_shared_prefs.dart';

class LangProvider extends ChangeNotifier {
  String currentLang = LangSharedPrefs.getSavedLang();

  void changeLang(int selectedLangIndex) {
    if (selectedLangIndex == 0) {
      currentLang = "ar";
      LangSharedPrefs.saveLang(currentLang);
    } else {
      currentLang = "en";
      LangSharedPrefs.saveLang(currentLang);
    }
    notifyListeners();
  }
}
