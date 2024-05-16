import '../validation/user/account_id_validation.dart';

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
