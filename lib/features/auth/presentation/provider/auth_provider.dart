// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/ui_utils.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  int selectedAvatar = 5;
  int currentValue = 0;
  bool visiblePassword = true;
  bool visibleConfirmPassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void pickAvatarImage(int avatarIndex) {
    selectedAvatar = avatarIndex;
    notifyListeners();
  }

  void switcher(int index) {
    currentValue = index;
    notifyListeners();
  }

  void changeConfirmPasswordVisibilityState() {
    visibleConfirmPassword = !visibleConfirmPassword;
    notifyListeners();
  }

  void changePasswordVisibilityState() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  String? confirmPasswordValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return "This field is required";
    } else if (input != passwordController.text) {
      return "Password does't match";
    } else {
      return null;
    }
  }

  void onCreateAccountClicked() {
    if (formKey.currentState?.validate() == false) return;
    notifyListeners();
  }
  void logInWithGoogle(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;

      googleSignIn.initialize(
        serverClientId:
            "551680118902-88fcok9inf335hlunlp02ussqjl2trim.apps.googleusercontent.com",
      );

      GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      GoogleSignInAuthentication googleAuth = googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      UiUtils.showLoadingDialog(context);

     
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      UiUtils.hideLoadingDialog(context);
      UiUtils.showToastificationBar(
        context,
        "Logged-In Successfully",
        ColorsManager.white,
        Colors.green,
        Icons.check_circle,
      );
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    } catch (ex) {
      print(ex.toString());
    }
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
