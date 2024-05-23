import 'package:flutter/cupertino.dart';

import '../pages/group/group_setting_page.dart';

class GroupBoxNavigator {
  GroupBoxNavigator(this.context, this.groupId);

  final BuildContext context;
  final String groupId;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<GroupSettingPage>>(
        builder: (context) => GroupSettingPage(groupId: groupId),
      ),
    );
  }
}
