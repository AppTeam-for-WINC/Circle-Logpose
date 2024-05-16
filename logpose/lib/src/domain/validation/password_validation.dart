import '../../../validation/max_length_validation.dart';
import '../../../validation/min_length_validation.dart';

class PasswordValidation {
  PasswordValidation._internal();
  static final PasswordValidation _instance = PasswordValidation._internal();
  static PasswordValidation get instance => _instance;

  static String? validation(String password) {
    const minLength8Validation = MinLength8Validation();
    const maxLength64Validation = MaxLength64Validation();

    final passwordMinLength8Validation = minLength8Validation.validate(
      password,
      'password',
    );
    final passwordMaxLength64Validation = maxLength64Validation.validate(
      password,
      'password',
    );
    if (!passwordMinLength8Validation) {
      return const MinLength8Validation().getMinLengthInvalidMessage();
    }
    if (!passwordMaxLength64Validation) {
      return const MaxLength64Validation().getMaxLengthInvalidMessage();
    }
    return null;
  }
}
