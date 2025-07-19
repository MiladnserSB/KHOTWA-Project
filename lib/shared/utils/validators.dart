class Validators {
  static bool isValidEmail(String email) => email.contains('@');
  static bool isValidPassword(String password) => password.length >= 6;
}