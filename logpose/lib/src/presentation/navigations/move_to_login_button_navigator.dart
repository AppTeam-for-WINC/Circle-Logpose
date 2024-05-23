import 'package:flutter/cupertino.dart';

import '../pages/login/log_in_page.dart';

class MoveToLogInButtonNavigator {
  MoveToLogInButtonNavigator(this.context);
  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<LogInPage>>(
        builder: (context) => const LogInPage(),
      ),
    );
  }
}
