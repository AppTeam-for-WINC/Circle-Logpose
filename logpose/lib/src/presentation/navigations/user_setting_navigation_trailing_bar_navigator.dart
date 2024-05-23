import 'package:flutter/cupertino.dart';

import '../pages/start/start_page.dart';
import 'pop_navigator.dart';

class UserSettingNavigationTrailingBarDialogNavigator {
  UserSettingNavigationTrailingBarDialogNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<StartPage>>(
        builder: (context) => const StartPage(),
      ),
    );
  }

  void cancel() {
    PopNavigator(context).pop();
  }
}
