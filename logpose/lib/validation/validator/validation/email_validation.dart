import '../../email_validation.dart';
import '../../max_length_validation.dart';
import '../../min_length_validation.dart';

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
      return const EmailValidation().emailInvalidMessage();
    }
    if (!emailMinLength8Validation) {
      return const MinLength8Validation().getMinLengthInvalidMessage();
    }
    if (!emailMaxLength32Validation) {
      return const MaxLength32Validation().getMaxLengthInvalidMessage();
    }

    return null;
  }
}
