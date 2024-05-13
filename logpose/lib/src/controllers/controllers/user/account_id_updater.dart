import 'package:firebase_core/firebase_core.dart';

import '../../../server/auth/auth_controller.dart';
import '../../../server/database/user_controller.dart';

import '../../validation/user/account_id_validation.dart';

/// Used with account_id_updater_provider.
class AccountIdUpdater {
  const AccountIdUpdater();

  Future<String?> update(String newAccountId) async {
    try {
      return await _attemptToUpdate(newAccountId);
    } on FirebaseException catch (e) {
      return 'Error: failed to update account ID. $e';
    }
  }

  Future<String?> _attemptToUpdate(String newAccountId) async {
    final userId = await _fetchUserDocId();
    if (userId == null) {
      return 'Error : No found user ID.';
    }

    final validationError = AccountIdValidation.validation(newAccountId);
    if (validationError != null) {
      return validationError;
    }

    final updateProcess = await _updateAccountId(userId, newAccountId);
    if (!updateProcess) {
      return 'Failed to update account ID.';
    }

    return null;
  }

  Future<String?> _fetchUserDocId() async {
    try {
      return AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
  }

  Future<bool> _updateAccountId(String userId, String newAccountId) async {
    try {
      return await UserController.updateAccountId(userId, newAccountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update account ID. ${e.message}');
    }
  }
}
