import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth/auth_controller.dart';

import '../../validation/password_validation.dart';

final passwordErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final passwordSettingProvider =
    StateNotifierProvider.autoDispose<_UserPasswordSetting, String?>(
  (ref) => _UserPasswordSetting(),
);

class _UserPasswordSetting extends StateNotifier<String?> {
  _UserPasswordSetting() : super(null);

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<String?> update(String password, String newPassword) async {
    try {
      final validationErrorMessage = PasswordValidation.validation(newPassword);
      if (validationErrorMessage != null) {
        return validationErrorMessage;
      }

      final email = await _readUserEmail();
      if (email == null) {
        throw Exception("Failed to read user's email.");
      }

      final updatePasswordErrorMessage =
          await AuthController.updateUserPassword(
        email,
        password,
        newPassword,
      );
      if (updatePasswordErrorMessage != null) {
        return updatePasswordErrorMessage;
      }

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Failed to update password. $e');
    }
  }

  Future<String?> _readUserEmail() async {
    final email = await AuthController.readEmail();
    return email;
  }
}
