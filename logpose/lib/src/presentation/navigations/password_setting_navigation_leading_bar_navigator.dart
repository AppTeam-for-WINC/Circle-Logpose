import 'package:flutter/cupertino.dart';

import '../pages/user/user_setting_page.dart';

class PasswordSettingNavigationLeadingBarNavigator {
  PasswordSettingNavigationLeadingBarNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<UserSettingPage>>(
        builder: (context) => const UserSettingPage(),
      ),
      (_) => false,
    );
  }
}
