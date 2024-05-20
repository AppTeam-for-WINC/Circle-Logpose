import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'validation/password_validation.dart';

final passwordValidatorProvider = Provider<PasswordValidator>(
  (ref) => const PasswordValidator(),
);

class PasswordValidator {
  const PasswordValidator();

  static String? _validatePassword(String password) {
    return PasswordValidation.validation(password);
  }

  String? validatePassword(String password) {
    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }
}
