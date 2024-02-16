import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../database/auth/auth_controller.dart';
import '../../../../../validation/validation.dart';

final passwordSettingProvider =
    StateNotifierProvider.autoDispose<UserPasswordSetting, String?>(
  (ref) => UserPasswordSetting(),
);

class UserPasswordSetting extends StateNotifier<String?> {
  UserPasswordSetting() : super(null) {
    passwordController.text = '';
    newPasswordController.text = '';
  }
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<bool> update(String password, String newPassword) async {
    try {
      final validation = _passwordValidation(newPassword);
      if (!validation) {
        return false;
      }
      final email = await _readUserEmail();
      if (email == null) {
        return false;
      }

      await AuthController.updateUserPassword(
        email,
        password,
        newPassword,
      );
      return true;
    } on FirebaseException catch (e) {
      throw Exception('Failed to update password. $e');
    }
  }

  Future<String?> _readUserEmail() async {
    final email = await AuthController.readEmail();
    return email;
  }

  bool _passwordValidation(String newPassword) {
    const minLength8Validation = MinLength8Validation();
    const maxLength64Validation = MaxLength64Validation();
    debugPrint('newPassword: $newPassword');

    final passwordMinLength8Validation = minLength8Validation.validate(
      newPassword,
      'newPassword',
    );
    final passwordMaxLength64Validation = maxLength64Validation.validate(
      newPassword,
      'newPassword',
    );
    if (!passwordMinLength8Validation) {
      final errorMessage =
          const MinLength8Validation().getMinLengthInvalidMessage();

      debugPrint('passwordError: $errorMessage');
      return false;
    }
    if (!passwordMaxLength64Validation) {
      final errorMessage =
          const MaxLength64Validation().getMaxLengthInvalidMessage();

      debugPrint('passwordError: $errorMessage');
      return false;
    }
    return true;
  }
}
