import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'validation/user_validation.dart';

final usernameValidatorProvider = Provider<UsernameValidator>(
  (ref) => const UsernameValidator(),
);

class UsernameValidator {
  const UsernameValidator();

  static String? _validateName(String name) {
    return UserValidation.validateName(name);
  }

  String? validateUser(String name) {
    final nameError = _validateName(name);
    if (nameError != null) {
      return nameError;
    }
    return null;
  }
}
