import 'package:flutter/widgets.dart';

import '../../../../../validation/max_length_validation.dart';
import '../../../../../validation/min_length_validation.dart';

class PasswordValidation {
  PasswordValidation._internal();
  static final PasswordValidation _instance = PasswordValidation._internal();
  static PasswordValidation get instance => _instance;

  static String? validation(String newPassword) {
    const minLength8Validation = MinLength8Validation();
    const maxLength64Validation = MaxLength64Validation();
    debugPrint('newPassword: $newPassword');

    final passwordMinLength8Validation = minLength8Validation.validate(
      newPassword,
      'newPassword',
    );
    final passwordMaxLength64Validation = maxLength64Validation.validate(
      newPassword,
      'newPassword',
    );
    if (!passwordMinLength8Validation) {
      final errorMessage =
          const MinLength8Validation().getMinLengthInvalidMessage();

      debugPrint('passwordError: $errorMessage');
      return errorMessage;
    }
    if (!passwordMaxLength64Validation) {
      final errorMessage =
          const MaxLength64Validation().getMaxLengthInvalidMessage();

      debugPrint('passwordError: $errorMessage');
      return errorMessage;
    }
    return null;
  }
}
