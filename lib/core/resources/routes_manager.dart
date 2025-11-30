import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/login/login_screen.dart';
import 'package:movies_app/features/auth/register/register_screen.dart';
import 'package:movies_app/features/onboarding/onboarding.dart';
abstract class RoutesManager{
static const String login ="login";
static const String register ="register";
static const String onboarding = "onboarding";

static Map<String,WidgetBuilder> routes ={
  login:(context)=>LoginScreen(),
  register:(context)=>RegisterScreen(),
  onboarding:(context)=>OnboardingScreen(),

};
}