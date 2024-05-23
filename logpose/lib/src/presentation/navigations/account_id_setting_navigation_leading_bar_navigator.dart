import 'package:flutter/cupertino.dart';

import '../pages/user/user_setting_page.dart';

class AccountIdSettingNavigationLeadingBarNavigator {
  AccountIdSettingNavigationLeadingBarNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      await Navigator.pushReplacement(
        context,
        CupertinoPageRoute<CupertinoPageRoute<UserSettingPage>>(
          builder: (_) => const UserSettingPage(),
        ),
      );
    }
  }
}
