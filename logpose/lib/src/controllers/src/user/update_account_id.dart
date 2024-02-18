import '../../../services/auth/auth_controller.dart';
import '../../../services/database/crud/user_controller.dart';

import 'validation/account_id_validation.dart';

class UpdateAccountId {
  UpdateAccountId._internal();
  static final UpdateAccountId _instance = UpdateAccountId._internal();
  static UpdateAccountId get instance => _instance;

  static Future<bool> update(String newAccountId) async {
    final userId = await AuthController.getCurrentUserId();
    if (userId == null) {
      throw Exception('Error : No found user ID.');
    }

    final validation = AccountIdValidation.validation(newAccountId);
    if (!validation) {
      return false;
    }

    final success = await UserController.updateAccountId(userId, newAccountId);
    if (!success) {
      return false;
    }

    return true;
  }
}
