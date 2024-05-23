import 'package:flutter/cupertino.dart';

import '../pages/user/user_setting_page.dart';

class PasswordSaveButtonNavigator {
  PasswordSaveButtonNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const UserSettingPage(),
      ),
    );
  }
}
