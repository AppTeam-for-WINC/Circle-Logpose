import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../server/auth/auth_controller.dart';

import '../../validation/email_validation.dart';
import '../../validation/password_validation.dart';

class SignUpController {
  Future<String?> signup(String email, String password) async {
    try {
      return await _executeSignUp(email, password);
    } on Exception catch (e) {
      return 'Error: failed to sign up.: $e';
    }
  }

  Future<String?> _executeSignUp(String email, String password) async {
    final validationError = _validateCredentials(email, password);
    if (validationError != null) {
      return validationError;
    }

    final success = await _createAccount(email, password);
    if (!success) {
      return 'Error: The email address is already in use by another account.';
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

  Future<bool> _createAccount(String email, String password) async {
    try {
      return AuthController.createAccount(email, password);
    } on FirebaseException catch (e) {
      debugPrint('Error: failed to create account. $e');
      return false;
    }
  }
}
