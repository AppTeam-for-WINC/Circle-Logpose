import 'package:flutter/cupertino.dart';

import '../pages/user/account_id_setting_page.dart';

class ToAccountIdSettingPageNavigator {
  ToAccountIdSettingPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<AccountIdSettingPage>>(
        builder: (context) => const AccountIdSettingPage(),
      ),
      (_) => false,
    );
  }
}
