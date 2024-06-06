import 'package:flutter/cupertino.dart';

import 'pop_navigator.dart';
import 'to_account_deletion_page_navigator.dart';

class AccountDeletionAlertDialogNavigator {
  AccountDeletionAlertDialogNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    final navigator = ToAccountDeletionPageNavigator(context);
    await navigator.moveToPage();
  }

  void cancel() {
    PopNavigator(context).pop();
  }
}
