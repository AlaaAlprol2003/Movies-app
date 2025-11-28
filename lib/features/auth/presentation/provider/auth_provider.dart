import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int selectedAvatar = 2;
  int currentValue = 0;
  bool visiblePassword = false;
  bool visibleConfirmPassword = false;
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
}