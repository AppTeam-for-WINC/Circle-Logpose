import 'package:flutter/cupertino.dart';

import '../pages/user/email_setting_next_page.dart';

class MoveToNextPageNavigator {
  MoveToNextPageNavigator({required this.context, required this.password});

  final BuildContext context;
  final String password;
  
  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<EmailSettingNextPage>>(
        builder: (context) => EmailSettingNextPage(password: password),
      ),
      (_) => false,
    );
  }
}
