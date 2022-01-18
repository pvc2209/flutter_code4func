class Validation {
  static bool isPhoneValid(String phone) {
    final regexPhone = RegExp(r"^[0-9]+$");

    return regexPhone.hasMatch(phone);
  }

  static bool isPassValid(String pass) {
    return pass.length > 6;
  }

  static bool isDisplayNameValid(String displayName) {
    return displayName.length > 5;
  }
}
