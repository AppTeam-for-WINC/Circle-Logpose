import '../../max_length_validation.dart';
import '../../required_validation.dart';

class AccountIdValidation {
  AccountIdValidation._internal();
  static final AccountIdValidation _instance = AccountIdValidation._internal();
  static AccountIdValidation get instance => _instance;

  static String? validateAccountId(String accountId) {
    const requiredValidation = RequiredValidation();
    const maxLength64Validation = MaxLength64Validation();

    final accountIdRequiredValidation = requiredValidation.validate(
      accountId,
      'accountId',
    );
    final accountIdMaxLength64Validation = maxLength64Validation.validate(
      accountId,
      'accountId',
    );
    if (!accountIdRequiredValidation) {
      return const RequiredValidation().getStringInvalidRequiredMessage();
    }
    if (!accountIdMaxLength64Validation) {
      return const MaxLength64Validation().getMaxLengthInvalidMessage();
    }

    return null;
  }
}
