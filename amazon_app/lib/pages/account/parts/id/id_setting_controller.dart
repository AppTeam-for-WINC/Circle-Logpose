import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';

Future<bool> changeAccountId(String newAccountId) async {
  final userId = await AuthController.getCurrentUserId();
    if (userId == null) {
      throw Exception('Error : No found user ID.');
    }
  
  final validation = accountIdValidation(newAccountId);
  if (!validation) {
    return false;
  }

  final success = await UserController.updateAccountId(userId, newAccountId);
  if (!success) {
    return false;
  }

  return true;
}

bool accountIdValidation(String accountId) {
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
