import 'package:flutter/widgets.dart';

import '../../../../../validation/max_length_validation.dart';
import '../../../../../validation/required_validation.dart';

/// User Validation
class UserValidation {
  UserValidation._internal();
  static final UserValidation _instance = UserValidation._internal();
  static UserValidation get instance => _instance;

  static bool validation(String name) {
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();
    final nameRequiredValidation = requiredValidation.validate(
      name,
      'name',
    );
    final nameMaxLength32Validation = maxLength32Validation.validate(
      name,
      'name',
    );
    if (!nameRequiredValidation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }
    if (!nameMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }

    return true;
  }
}
