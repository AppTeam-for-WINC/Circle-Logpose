import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/account_deletion_confirmation_alert_dialog_handler.dart';
import '../../../../navigations/pop_navigator.dart';

class AccountDeletionConfirmationAlertDialog extends ConsumerStatefulWidget {
  const AccountDeletionConfirmationAlertDialog({super.key});

  @override
  ConsumerState<AccountDeletionConfirmationAlertDialog> createState() =>
      _AccountDeletionConfirmationAlertDialogState();
}

class _AccountDeletionConfirmationAlertDialogState
    extends ConsumerState<AccountDeletionConfirmationAlertDialog> {
  @override
  Widget build(BuildContext context) {
    Future<void> handleToExecute() async {
      final handler =
          AccountDeletionConfirmationAlertDialogHandler(context, ref);
      await handler.handleToDeleteAccount();
    }

    void cancel() {
      PopNavigator(context).pop;
    }

    return CupertinoAlertDialog(
      title: const Text('本当にアカウントを削除しますか?'),
      content: const Text('一度削除したアカウントを復元することはできません。'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: handleToExecute,
          child: const Text('Yes'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: cancel,
          child: const Text('No'),
        ),
      ],
    );
  }
}
