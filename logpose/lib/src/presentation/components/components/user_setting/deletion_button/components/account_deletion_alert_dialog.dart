import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/account_deletion_alert_dialog_navigator.dart';

class AccountDeletionAlertDialog extends ConsumerStatefulWidget {
  const AccountDeletionAlertDialog({super.key});

  @override
  ConsumerState<AccountDeletionAlertDialog> createState() =>
      _AccountDeletionAlertDialogState();
}

class _AccountDeletionAlertDialogState
    extends ConsumerState<AccountDeletionAlertDialog> {
  @override
  Widget build(BuildContext context) {
    Future<void> handleToExecute() async {
      final navigator = AccountDeletionAlertDialogNavigator(context);
      await navigator.moveToPage();
    }

    void cancel() {
      final navigator = AccountDeletionAlertDialogNavigator(context);
      navigator.cancel();
    }

    return CupertinoAlertDialog(
      title: const Text('アカウントを削除しますか?'),
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
