import '../../rules/max_length_validation.dart';
import '../../rules/required_validation.dart';

/// Validation of group
class GroupValidation {
  GroupValidation._internal();
  static final GroupValidation _instance = GroupValidation._internal();
  static GroupValidation get instance => _instance;

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
