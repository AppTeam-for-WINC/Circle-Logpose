import 'package:firebase_core/firebase_core.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/user_controller.dart';

import '../../validation/user/account_id_validation.dart';

class UpdateAccountId {
  UpdateAccountId._internal();
  static final UpdateAccountId _instance = UpdateAccountId._internal();
  static UpdateAccountId get instance => _instance;

  static Future<String?> update(String newAccountId) async {
    try {
      final userId = await _fetchUserDocId();
      if (userId == null) {
        return 'Error : No found user ID.';
      }

      final accountIdValidation = AccountIdValidation.validation(newAccountId);
      if (accountIdValidation != null) {
        return accountIdValidation;
      }

      final success = await _updateAccountId(userId, newAccountId);
      if (!success) {
        return 'Failed to update account ID.';
      }

      return null;
    } on FirebaseException catch (e) {
      return 'Error: failed to update account ID. $e';
    }
  }

  static Future<String?> _fetchUserDocId() async {
    return AuthController.getCurrentUserId();
  }

  static Future<bool> _updateAccountId(
    String userId,
    String newAccountId,
  ) async {
    return UserController.updateAccountId(userId, newAccountId);
  }
}
