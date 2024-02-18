import '../../../validation/email_validation.dart';
import '../../../validation/max_length_validation.dart';
import '../../../validation/min_length_validation.dart';

class UserEmailValidation {
  UserEmailValidation._internal();
  static final UserEmailValidation _instance = UserEmailValidation._internal();
  static UserEmailValidation get instance => _instance;

  static String? validation(String email) {
    const typeValidation = EmailValidation();
    const minLength8Validation = MinLength8Validation();
    const maxLength32Validation = MaxLength32Validation();

    final emailTypeValidation = typeValidation.validate(
      email,
      'email',
    );
    final emailMinLength8Validation = minLength8Validation.validate(
      email,
      'email',
    );
    final emailMaxLength32Validation = maxLength32Validation.validate(
      email,
      'email',
    );
    if (!emailTypeValidation) {
      final errorMessage = const EmailValidation().emailInvalidMessage();

      return errorMessage;
    }
    if (!emailMinLength8Validation) {
      final errorMessage =
          const MinLength8Validation().getMinLengthInvalidMessage();

      return errorMessage;
    }
    if (!emailMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      return errorMessage;
    }

    return null;
  }
}
