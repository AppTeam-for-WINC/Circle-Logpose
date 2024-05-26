import 'package:flutter/cupertino.dart';

import '../../components/components/navigation_bar/user_setting_navigation/components/components/user_setting_navigation_trailing_bar_dialog.dart';

class UserSettingNavigationTrailingBarModalNavigator {
  UserSettingNavigationTrailingBarModalNavigator(this.context);

  final BuildContext context;

  Future<void> showModal() async {
    await showCupertinoModalPopup<UserSettingNavigationTrailingBarDialog>(
      context: context,
      builder: (BuildContext context) {
        return const UserSettingNavigationTrailingBarDialog();
      },
    );
  }
}
