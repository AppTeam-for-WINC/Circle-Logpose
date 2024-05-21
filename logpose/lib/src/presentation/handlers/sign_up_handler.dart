// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/text_field/email_field_provider.dart';
import '../../domain/providers/text_field/password_field_provider.dart';

import '../components/common/loading_progress.dart';

import '../controllers/sign_up_controller.dart';
import '../navigations/sign_up_navigator.dart';

class SignUpHandler {
  const SignUpHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleSignUp() async {
    final email = ref.read(emailFieldProvider('')).text;
    final password = ref.read(passwordFieldProvider('')).text;
    final signUpController = ref.read(signUpControllerProvider);

    _loadingProgress(true);
    final errorMessage = await signUpController.performSignUp(email, password);
    _loadingProgress(false);

    if (errorMessage != null) {
      _loadingErrorMessage(errorMessage);
      return;
    }

    if (context.mounted) {
      await SignUpNavigator(context).moveToNextPage(context);
    }
  }

  void _loadingProgress(bool loading) {
    ref.read(loadingProgressControllerProvider).loadingProgress = loading;
  }

  void _loadingErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }
}
