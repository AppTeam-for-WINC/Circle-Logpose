import 'package:flutter/cupertino.dart';

import '../../components/components/navigation_bar/group_setting_navigation/components/group_setting_navigation_trailing_bar_dialog.dart';

class GroupSettingNavigationTrailingBarModalNavigator {
  GroupSettingNavigationTrailingBarModalNavigator(this.context, this.groupId);

  final BuildContext context;
  final String groupId;

  Future<void> showModal() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return GroupSettingNavigationTrailingBarDialog(groupId: groupId);
      },
    );
  }
}
