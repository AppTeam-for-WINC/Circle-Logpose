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

      final loginValidation = _loginValidation(email, password);
      if (loginValidation != null) {
        return loginValidation;
      }

      final signupSuccess = await _loadingProgress(ref, email, password);
      if (!signupSuccess) {
        return 'The email address is already in use by another account.';
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

  static String? _loginValidation(String email, String password) {
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

  static Future<bool> _loadingProgress(
    WidgetRef ref,
    String email,
    String password,
  ) async {
    LoadingProgressController.loadingProgress(ref, loading: true);
    final loginSuccess = await AuthController.loginToAccount(email, password);
    LoadingProgressController.loadingProgress(ref, loading: false);

    return loginSuccess;
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
