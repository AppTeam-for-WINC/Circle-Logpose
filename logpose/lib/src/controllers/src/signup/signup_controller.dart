import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth/auth_controller.dart';

import '../../../views/src/login/login_page.dart';

import '../../common/loading/loading_progress.dart';

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
    final email = emailController.text;
    final password = passwordController.text;

    final emailErrorMessage = UserEmailValidation.validation(email);
    if (emailErrorMessage != null) {
      return emailErrorMessage;
    }
    final passwordErrorMessage = PasswordValidation.validation(password);
    if (passwordErrorMessage != null) {
      return passwordErrorMessage;
    }

    LoadingProgressController.loadingProgress(ref, loading: true);
    final signupSuccess = await AuthController.createAccount(email, password);
    LoadingProgressController.loadingProgress(ref, loading: false);

    if (!signupSuccess) {
      return 'The email address is already in use by another account.';
    }

    // Check if the widget is still in the tree.
    if (context.mounted) {
      await Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
          builder: (context) => const LoginPage(),
        ),
        (_) => false,
      );
    }

    return null;
  }
}
