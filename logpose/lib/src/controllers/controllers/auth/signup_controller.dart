import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/loading_progress.dart';
import '../../../services/auth/auth_controller.dart';
import '../../../views/src/login/login_page.dart';

import '../../validation/email_validation.dart';
import '../../validation/password_validation.dart';

class SignupController {
  SignupController._internal();
  static final SignupController _instance = SignupController._internal();
  static SignupController get instance => _instance;

  static Future<String?> signup(
    BuildContext context,
    WidgetRef ref,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      final signUpValidation = _signUpValidation(email, password);
      if (signUpValidation != null) {
        return signUpValidation;
      }

      _loadingProgress(ref, true);
      final success = await _createAccount(email, password);
      _loadingProgress(ref, false);
      if (!success) {
        return 'Error: The email address is already in use by another account.';
      }

      // Check if the widget is still in the tree.
      if (context.mounted) {
        await _moveToNextPage(context);
      }

      return null;
    } on Exception catch (e) {
      return 'Error to sign up.: $e';
    }
  }

  static String? _signUpValidation(String email, String password) {
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

  static Future<bool> _createAccount(String email, String password) async {
    try {
      return AuthController.createAccount(email, password);
    } on FirebaseException catch (e) {
      debugPrint('Error: failed to create account. $e');
      return false;
    }
  }

  static void _loadingProgress(WidgetRef ref, bool loading) {
    LoadingProgressController.loadingProgress(ref, loading: loading);
  }

  static Future<void> _moveToNextPage(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const LoginPage(),
      ),
      (_) => false,
    );
  }
}
