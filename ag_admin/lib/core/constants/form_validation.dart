class FormValidator {
  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter a value";
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username required*";
    }
    return null;
  }

  static String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required*";
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name != null && name.split(" ").length > 1 && name.length <= 50) {
      return null;
    } else if (name != null && name.length > 50) {
      return "Name cannot be more than 50 characters";
    } else {
      return "Name should be more than or equal to 2 words.";
    }
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return "Please enter a email adress.";
    } else if (email.length > 50) {
      return "Email cannot be more than 50 characters.";
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return null;
    } else {
      return "Please enter a valid email address";
    }
  }

  static String? validateMobileNum(String? mobileNum) {
    if (mobileNum != null && mobileNum.startsWith('+977')
        ? mobileNum.length == 14
        : mobileNum?.length == 10 && mobileNum!.startsWith('98') ||
            mobileNum!.startsWith('97') ||
            mobileNum.startsWith('96')) {
      return null;
    } else if (mobileNum.isEmpty) {
      return "Mobile Number required*";
    }
    return "Please enter a valid mobile number";
  }
}
