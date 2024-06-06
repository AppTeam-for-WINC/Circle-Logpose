import 'package:flutter/cupertino.dart';

import '../../components/components/account_deletion/components/account_deletion_confirmation_alert_dialog.dart';

class ToAccountDeletionConfirmationAlertDialogNavigator {
  ToAccountDeletionConfirmationAlertDialogNavigator(this.context);

  final BuildContext context;

  Future<void> showModal() async {
    await showCupertinoModalPopup<AccountDeletionConfirmationAlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AccountDeletionConfirmationAlertDialog();
      },
    );
  }
}
