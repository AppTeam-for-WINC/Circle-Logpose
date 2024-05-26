import 'package:flutter/cupertino.dart';

import '../pages/user/email_setting_page.dart';

class ToEmailSettingPageNavigator {
  ToEmailSettingPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<EmailSettingPage>>(
        builder: (context) => const EmailSettingPage(),
      ),
      (_) => false,
    );
  }
}
