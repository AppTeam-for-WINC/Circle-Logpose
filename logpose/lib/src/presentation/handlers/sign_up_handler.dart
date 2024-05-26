// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/common/loading_progress.dart';

import '../controllers/auth/auth_authentication_controller.dart';
import '../navigations/to_log_in_page_navigator.dart';

import '../providers/text_field/email_field_provider.dart';
import '../providers/text_field/password_field_provider.dart';

class SignUpHandler {
  const SignUpHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleSignUp() async {
    _loadingProgress(true);
    final errorMessage = await _signUp();
    _loadingProgress(false);

    if (errorMessage != null) {
      _loadingErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<String?> _signUp() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;
    final signUpController = ref.read(authAuthenticationControllerProvider);

    return signUpController.signUp(email, password);
  }

  void _loadingProgress(bool loading) {
    ref.read(loadingProgressControllerProvider).loadingProgress = loading;
  }

  void _loadingErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      await ToLogInPageNavigator(context).moveToPage();
    }
  }
}
