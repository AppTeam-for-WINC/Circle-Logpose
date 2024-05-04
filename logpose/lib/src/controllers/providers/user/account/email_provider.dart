import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../validation/email_validation.dart';

final userEmailProvider =
    StateNotifierProvider.autoDispose<_UserEmail, String?>(
  (ref) => _UserEmail(),
);

class _UserEmail extends StateNotifier<String?> {
  _UserEmail() : super(null) {
    initUserEmail();
  }

  String? userEmail;

  Future<void> initUserEmail() async {
    final email = await _fetchEmail();
    if (email == null) {
      return;
    }
    state = email;
    userEmail = email;
  }

  Future<String?> _fetchEmail() async {
    return AuthController.readEmail();
  }

  Future<bool> changeEmail(String newEmail) async {
    final validation = UserEmailValidation.validation(newEmail);
    if (validation != null) {
      return false;
    }

    final emailVerification = await AuthController.sendConfirmationEmail();
    if (!emailVerification) {
      return false;
    }
    
    final success = await AuthController.updateUserEmail(userEmail!, newEmail);
    if (!success) {
      return false;
    }

    return true;
  }
}
