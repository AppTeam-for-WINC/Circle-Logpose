// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/text_field/email_field_provider.dart';
import '../../domain/providers/text_field/password_field_provider.dart';

import '../components/common/loading_progress.dart';

import '../controllers/log_in_controller.dart';
import '../navigations/log_in_navigator.dart';

class LoginHandler {
  const LoginHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleLogin() async {
    _updateLoadingStatus(true);
    final errorMessage = await _login();
    _updateLoadingStatus(false);

    if (errorMessage != null) {
      _displayErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<String?> _login() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;
    final logInController = ref.read(logInControllerProvider);

    return logInController.performLogin(email, password);
  }

  void _updateLoadingStatus(bool loading) {
    ref.read(loadingProgressControllerProvider).loadingProgress = loading;
  }

  void _displayErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      await LoginNavigator(context).moveToPage();
    }
  }
}
