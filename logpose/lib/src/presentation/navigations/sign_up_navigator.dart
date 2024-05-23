import 'package:flutter/cupertino.dart';

import '../pages/login/log_in_page.dart';

class SignUpNavigator {
  SignUpNavigator(this.context);
  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<LogInPage>>(
        builder: (context) => const LogInPage(),
      ),
      (_) => false,
    );
  }
}
