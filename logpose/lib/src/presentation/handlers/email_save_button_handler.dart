// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/error_message/email_error_message_provider.dart';
import '../../domain/providers/text_field/email_field_provider.dart';

import '../controllers/email_save_button_controller.dart';
import '../navigations/email_save_button_navigator.dart';

class EmailSaveButtonHandler {
  EmailSaveButtonHandler({
    required this.context,
    required this.ref,
    required this.password,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String password;

  Future<void> handleEmail() async {
    final errorMessage = await _updateEmail();
    if (errorMessage != null) {
      _setErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<String?> _updateEmail() async {
    final emailController = ref.read(emailSaveButtonControllerProvider);
    final newEmail = ref.watch(emailFieldProvider('')).text;

    return emailController.updateEmail(newEmail, password);
  }

  void _setErrorMessage(String errorMessage) {
    ref.watch(emailErrorMessageProvider.notifier).state = errorMessage;
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      final navigator = EmailSaveButtonNavigator(context);
      await navigator.moveToPage();
    }
  }
}
