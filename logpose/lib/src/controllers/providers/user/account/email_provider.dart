import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../validation/email_validation.dart';

final userEmailProvider =
    StateNotifierProvider.autoDispose<_UserEmail, String?>(
  (ref) => _UserEmail(),
);

class _UserEmail extends StateNotifier<String?> {
  _UserEmail() : super(null) {
    readUserEmail();
  }

  TextEditingController emailController = TextEditingController();
  String? userEmail;

  Future<void> readUserEmail() async {
    final email = await AuthController.readEmail();
    if (email == null) {
      return;
    }
    state = email;
    userEmail = email;
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
