import 'validation/user/user_validation.dart';

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
