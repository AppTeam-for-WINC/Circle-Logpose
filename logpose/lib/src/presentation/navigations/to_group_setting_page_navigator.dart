import 'package:flutter/cupertino.dart';

import '../pages/group/group_setting_page.dart';

class ToGroupSettingPageNavigator {
  ToGroupSettingPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage(String groupId) async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<GroupSettingPage>>(
        builder: (context) => GroupSettingPage(groupId: groupId),
      ),
    );
  }
}
