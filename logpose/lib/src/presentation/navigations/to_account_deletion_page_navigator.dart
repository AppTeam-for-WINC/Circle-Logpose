import 'package:flutter/cupertino.dart';

import '../pages/user/account_deletion_page.dart';

class ToAccountDeletionPageNavigator {
  ToAccountDeletionPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<AccountDeletionPage>>(
        builder: (context) => const AccountDeletionPage(),
      ),
    );
  }
}
