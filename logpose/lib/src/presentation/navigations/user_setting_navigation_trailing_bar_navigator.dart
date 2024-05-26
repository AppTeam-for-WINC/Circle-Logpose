import 'package:flutter/cupertino.dart';

import 'pop_navigator.dart';
import 'to_start_page_navigator.dart';

class UserSettingNavigationTrailingBarDialogNavigator {
  UserSettingNavigationTrailingBarDialogNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    final navigator = ToStartPageNavigator(context);
    await navigator.moveToPage();
  }

  void cancel() {
    PopNavigator(context).pop();
  }
}
