import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/loading_progress.dart';
import '../../../components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../../../services/auth/auth_controller.dart';
import '../../validation/email_validation.dart';
import '../../validation/password_validation.dart';

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
    try {
      final email = emailController.text;
      final password = passwordController.text;

      final loginValidation = _loginValidation(email, password);
      if (loginValidation != null) {
        return loginValidation;
      }

      final loginSuccess = await _loadingProgress(ref, email, password);
      if (!loginSuccess) {
        return 'Password or Email is not correct.';
      }

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
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }
}
