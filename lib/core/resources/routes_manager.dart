import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/login/login_screen.dart';
import 'package:movies_app/features/auth/register/register_screen.dart';
import 'package:provider/provider.dart';

import '../../features/main_layout/main_layout.dart';
import '../../features/main_layout/main_layout_provider.dart';

abstract class RoutesManager {
  static const String login = "login";
  static const String register = "register";
  static const String mainLayout = "mainLayout";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),

    mainLayout: (context) => ChangeNotifierProvider(
      create: (context) => MainLayoutProvider(),
      child: MainLayout(),
    ),
  };
}
