import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/common/loading/loading_progress.dart';
import '../../../controllers/validation/email_validation.dart';
import '../../../controllers/validation/password_validation.dart';

import '../../../services/auth/auth_controller.dart';

import '../../../views/src/home/home_page.dart';

class LoginController {
  LoginController._internal();
  static final LoginController _instance = LoginController._internal();
  static LoginController get instance => _instance;

  static Future<String?> login(
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
    final loginSuccess = await AuthController.loginToAccount(email, password);
    LoadingProgressController.loadingProgress(ref, loading: false);

    if (!loginSuccess) {
      return 'Password or Email is not correct.';
    }

    if (context.mounted) {
      await Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
          builder: (context) => const HomePage(),
        ),
        (_) => false,
      );
    }
    return null;
  }
}
