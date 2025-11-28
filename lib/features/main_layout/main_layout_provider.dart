import 'package:flutter/cupertino.dart';
import 'package:movies_app/features/main_layout/tabs/browse_tab.dart';
import 'package:movies_app/features/main_layout/tabs/home_tab.dart';
import 'package:movies_app/features/main_layout/tabs/profile_tab.dart';
import 'package:movies_app/features/main_layout/tabs/search_tab.dart';

class MainLayoutProvider extends ChangeNotifier{

  int selectedTab = 0;
  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  void changeTab(int index){
    selectedTab = index;
    notifyListeners();
  }
}

