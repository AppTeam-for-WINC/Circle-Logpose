import 'package:flutter/widgets.dart';

import '../../../../validation/max_length_validation.dart';
import '../../../../validation/required_validation.dart';

class AccountIdValidation {
    AccountIdValidation._internal();
  static final AccountIdValidation _instance = AccountIdValidation._internal();
  static AccountIdValidation get instance => _instance;

  static bool validation(String accountId) {
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
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('accountIdError: $errorMessage');
      return false;
    }
    if (!accountIdMaxLength64Validation) {
      final errorMessage =
          const MaxLength64Validation().getMaxLengthInvalidMessage();

      debugPrint('accountIdError: $errorMessage');
      return false;
    }

    return true;
  }
}
