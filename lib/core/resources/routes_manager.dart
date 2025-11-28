import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:movies_app/features/auth/presentation/screens/login_screen.dart';
import 'package:movies_app/features/auth/presentation/screens/register_screen.dart';
import 'package:provider/provider.dart';

abstract class RoutesManager {
  static const String login = "login";
  static const String register = "register";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: RegisterScreen(),
    ),
  };
}
