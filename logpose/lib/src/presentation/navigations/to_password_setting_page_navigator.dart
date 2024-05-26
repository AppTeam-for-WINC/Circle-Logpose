import 'package:flutter/cupertino.dart';

import '../pages/user/password_setting_page.dart';

class ToPasswordSettingPageNavigator {
  ToPasswordSettingPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<PasswordSettingPage>>(
        builder: (context) => const PasswordSettingPage(),
      ),
      (_) => false,
    );
  }
}
