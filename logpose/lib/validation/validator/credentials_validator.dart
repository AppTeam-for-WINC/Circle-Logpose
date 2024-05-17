import 'validation/email_validation.dart';
import 'validation/password_validation.dart';

class CredentialsValidator {
  const CredentialsValidator();

  static String? _validateEmail(String email) {
    return UserEmailValidation.validation(email);
  }

  static String? _validatePassword(String password) {
    return PasswordValidation.validation(password);
  }

  String? validateCredentials(String email, String password) {
    final emailError = _validateEmail(email);
    if (emailError != null) {
      return emailError;
    }
    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }
}
