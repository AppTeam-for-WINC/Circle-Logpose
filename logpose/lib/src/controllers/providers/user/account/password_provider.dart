import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../validation/password_validation.dart';
import '../../text_field/new_password_field_provider.dart';
import '../../text_field/password_field_provider.dart';

final passwordSettingProvider = Provider.autoDispose<_UserPasswordSetting>(
  (ref) => _UserPasswordSetting(),
);

class _UserPasswordSetting {
  Future<String?> update(WidgetRef ref) async {
    final newPasswordController = ref.watch(newPasswordFieldProvider);
    final validationPasswordError =
        _validationPassword(newPasswordController.text);
    if (validationPasswordError != null) {
      return validationPasswordError;
    }

    // Get user email
    final email = await _readUserEmail();
    if (email == null) {
      return "Failed to read user's email.";
    }

    return _updateUserPassword(email, ref);
  }

  // Validate new password
  String? _validationPassword(String newPassword) {
    final passwordError = PasswordValidation.validation(newPassword);
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }

  Future<String?> _updateUserPassword(String email, WidgetRef ref) async {
    final newPassword = ref.watch(newPasswordFieldProvider).text;
    final password = ref.watch(passwordFieldProvider('')).text;

    // Attempt to update password
    // Returns null if no error
    try {
      return AuthController.updateUserPassword(
        email,
        password,
        newPassword,
      );
    } on FirebaseException catch (e) {
      return 'Failed to update password: ${e.message}';
    }
  }

  Future<String?> _readUserEmail() async {
    return AuthController.readEmail();
  }
}
