import 'package:flutter/cupertino.dart';

import '../pages/user/email_setting_next_page.dart';

class ToEmailSettingNextPageNavigator {
  ToEmailSettingNextPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage(String password) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<EmailSettingNextPage>>(
        builder: (context) => EmailSettingNextPage(password: password),
      ),
      (_) => false,
    );
  }
}
