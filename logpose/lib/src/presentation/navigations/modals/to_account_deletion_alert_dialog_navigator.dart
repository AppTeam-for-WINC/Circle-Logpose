import 'package:flutter/cupertino.dart';

import '../../components/components/user_setting/deletion_button/components/account_deletion_alert_dialog.dart';

class ToAccountDeletionAlertDialogNavigator {
  ToAccountDeletionAlertDialogNavigator(this.context);

  final BuildContext context;

  Future<void> showModal() async {
    await showCupertinoModalPopup<AccountDeletionAlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AccountDeletionAlertDialog();
      },
    );
  }
}
