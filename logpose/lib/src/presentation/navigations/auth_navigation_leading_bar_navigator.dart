import 'package:flutter/cupertino.dart';

import '../pages/start/start_page.dart';

class AuthNavigationLeadingBarNavigator {
  AuthNavigationLeadingBarNavigator(this.context);

  final BuildContext context;

  void moveToPage() {
    Navigator.pop(
      context,
      CupertinoPageRoute<CupertinoPageRoute<StartPage>>(
        builder: (context) => const StartPage(),
      ),
    );
  }
}
