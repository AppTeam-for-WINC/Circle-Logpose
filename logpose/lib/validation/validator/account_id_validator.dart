import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'validation/account_id_validation.dart';

final accountIdValidatorProvider = Provider<AccountIdValidator>(
  (ref) => const AccountIdValidator(),
);

class AccountIdValidator {
  const AccountIdValidator();

  static String? _validateAccountId(String accountId) {
    return AccountIdValidation.validateAccountId(accountId);
  }

  String? validateAccountId(String accountId) {
    final accountIdError = _validateAccountId(accountId);
    if (accountIdError != null) {
      return accountIdError;
    }
    return null;
  }
}
