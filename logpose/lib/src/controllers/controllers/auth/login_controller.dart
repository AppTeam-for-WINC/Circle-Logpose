import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../server/auth/auth_controller.dart';

import '../../validation/email_validation.dart';
import '../../validation/password_validation.dart';

/// Used with loginControllerProvider.
class LoginController {
  Future<String?> login(String email, String password) async {
    try {
      return await _executeLogin(email, password);
    } on Exception catch (e) {
      return 'Error: failed to log in account.: $e';
    }
  }

  Future<String?> _executeLogin(String email, String password) async {
    final validationError = _validateCredentials(email, password);
    if (validationError != null) {
      return validationError;
    }

    final loginProcess = await _loginToAccount(email, password);
    if (!loginProcess) {
      return 'Password or Email is not correct.';
    }

    return null;
  }

  String? _validateCredentials(String email, String password) {
    final emailError = UserEmailValidation.validation(email);
    if (emailError != null) {
      return emailError;
    }
    final passwordError = PasswordValidation.validation(password);
    if (passwordError != null) {
      return passwordError;
    }

    return null;
  }

  Future<bool> _loginToAccount(String email, String password) async {
    try {
      return await AuthController.loginToAccount(email, password);
    } on FirebaseException catch (e) {
      debugPrint('Error: failed to login account. ${e.message}');
      return false;
    }
  }
}
