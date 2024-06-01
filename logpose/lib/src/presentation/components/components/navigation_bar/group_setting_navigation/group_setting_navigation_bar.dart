import 'package:flutter/cupertino.dart';

import '../../../common/back_to_page_button.dart';

import 'components/group_setting_navigation_middle_bar.dart';
import 'components/group_setting_navigation_trailing_bar.dart';

class GroupSettingNavigationBar extends CupertinoNavigationBar {
  GroupSettingNavigationBar({super.key, required this.groupId})
      : super(
          leading: const BackToPageButton(iconColor: Color(0xFF7B61FF)),
          backgroundColor: const Color.fromARGB(255, 233, 233, 246),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
          middle: const GroupSettingNavigationMiddleBar(),
          trailing: GroupSettingNavigationTrailingBar(groupId: groupId),
        );

  final String groupId;
}
