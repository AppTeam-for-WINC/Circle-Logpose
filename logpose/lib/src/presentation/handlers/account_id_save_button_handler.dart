// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user/user_update_controller.dart';

import '../navigations/to_user_setting_page_navigator.dart';
import '../notifiers/user_profile_notifier.dart';

import '../providers/error_message/account_id_error_message_provider.dart';
import '../providers/text_field/account_id_field_provider.dart';

class AccountIdSaveButtonHandler {
  const AccountIdSaveButtonHandler({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleAccountId() async {
    final newAccountId = ref.read(accountIdFieldProvider('')).text;
    final errorMessage = await _update(newAccountId);

    if (errorMessage != null) {
      _setErrorMessage(errorMessage);
      return;
    }
    
    _setNewAccountId(newAccountId);

    await _moveToPage();
  }

  Future<String?> _update(String newAccountId) async {
    final accountIdController =
        ref.read(userUpdateControllerProvider);
    return accountIdController.updateAccountId(newAccountId);
  }

  void _setErrorMessage(String errorMessage) {
    ref.watch(accountIdErrorMessageProvider.notifier).state = errorMessage;
  }

  void _setNewAccountId(String newAccountId) {
    ref
        .watch(userProfileNotifierProvider.notifier)
        .setNewAccountId(newAccountId);
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      final navigator = ToUserSettingPageNavigator(context);
      await navigator.moveToPage();
    }
  }
}
