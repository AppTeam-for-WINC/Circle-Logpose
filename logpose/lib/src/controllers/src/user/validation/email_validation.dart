import 'package:flutter/widgets.dart';

import '../../../../../validation/email_validation.dart';
import '../../../../../validation/max_length_validation.dart';
import '../../../../../validation/min_length_validation.dart';

class UserEmailValidation {
  UserEmailValidation._internal();
  static final UserEmailValidation _instance = UserEmailValidation._internal();
  static UserEmailValidation get instance => _instance;

  static bool validation(String newEmail) {
    const typeValidation = EmailValidation();
    const minLength8Validation = MinLength8Validation();
    const maxLength32Validation = MaxLength32Validation();

    final emailTypeValidation = typeValidation.validate(
      newEmail,
      'newEmail',
    );
    final emailMinLength8Validation = minLength8Validation.validate(
      newEmail,
      'newEmail',
    );
    final emailMaxLength32Validation = maxLength32Validation.validate(
      newEmail,
      'newEmail',
    );
    if (!emailTypeValidation) {
      final errorMessage = const EmailValidation().emailInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }
    if (!emailMinLength8Validation) {
      final errorMessage =
          const MinLength8Validation().getMinLengthInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }
    if (!emailMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }

    return true;
  }
}
