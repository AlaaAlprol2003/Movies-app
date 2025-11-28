class AppValidators {
  static String? nameValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? emailValidator(String? input) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (input == null || input.trim().isEmpty) {
      return "This field is required";
    } else if (!emailRegex.hasMatch(input)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? input) {
    RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    if (input == null || input.trim().isEmpty) {
      return "This field is required";
    } else if (!passwordRegex.hasMatch(input)) {
      return "Enter valid password";
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? input) {
    RegExp phoneRegex = RegExp(r'^\+20\d{10}$');

    if (input == null || input.trim().isEmpty) {
      return "This field is required";
    } else if (!phoneRegex.hasMatch(input) ) {
      return "Enter valid phone number\nPhone must start with +20 and 10 numbers";
    } else {
      return null;
    }
  }
}
