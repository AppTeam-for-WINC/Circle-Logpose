import '../../../max_length_validation.dart';
import '../../../required_validation.dart';

/// User Validation
class UserValidation {
  UserValidation._internal();
  static final UserValidation _instance = UserValidation._internal();
  static UserValidation get instance => _instance;

  static String? validateName(String name) {
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
      return const RequiredValidation().getStringInvalidRequiredMessage();
    }
    if (!nameMaxLength32Validation) {
      return const MaxLength32Validation().getMaxLengthInvalidMessage();
    }

    return null;
  }
}
