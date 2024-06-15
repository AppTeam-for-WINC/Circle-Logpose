// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../validation/validator/validator_controller.dart';

import '../controllers/auth/auth_account_deletion_controller.dart';
import '../controllers/auth/auth_management_controller.dart';
import '../navigations/to_start_page_navigator.dart';

import '../providers/error_message/password_error_message_provider.dart';
import '../providers/text_field/password_field_provider.dart';

class AccountDeletionConfirmationAlertDialogHandler {
  const AccountDeletionConfirmationAlertDialogHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleToDeleteAccount() async {
    final email = await _getEmail();

    if (email == null) {
      return;
    }

    final password = _getInputPassword();
    print('email: $email, password: $password');
    final errorMessage = await _validatePassword(password);
    print('errorMessage: $errorMessage');
    if (errorMessage != null) {
      _setErrorMessage(errorMessage);
      return;
    }
    print('test');
    await _deleteAccount(email, password);
    print('hello');
    await _moveToPage();
    print('deleted');
  }

  Future<String?> _getEmail() async {
    final authController = ref.read(authManagementControllerProvider);
    return authController.fetchUserEmail();
  }

  String _getInputPassword() {
    return ref.read(passwordFieldProvider('')).text;
  }

  Future<String?> _validatePassword(String password) async {
    final validationController = ref.read(validatorControllerProvider);
    return validationController.validatePassword(password);
  }

  void _setErrorMessage(String errorMessage) {
    ref.watch(passwordErrorMessageProvider.notifier).state = errorMessage;
  }

  Future<void> _deleteAccount(String email, String password) async {
    final authAccountDeletionController =
        ref.read(authAccountDeletionControllerProvider);
    await authAccountDeletionController.deleteAccount(email, password);
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      final navigator = ToStartPageNavigator(context);
      await navigator.moveToPage();
    }
  }
}
