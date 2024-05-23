import 'package:flutter/cupertino.dart';

import 'components/user_setting_navigation_leading_bar.dart';
import 'components/user_setting_navigation_middle_bar.dart';
import 'components/user_setting_navigation_trailing_bar.dart';

class UserSettingNavigationBar extends CupertinoNavigationBar {
  const UserSettingNavigationBar({super.key})
      : super(
          leading: const UserSettingNavigationLeadingBar(),
          backgroundColor: const Color(0xFFF5F3FE),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
          middle: const UserSettingNavigationMiddleBar(),
          trailing: const UserSettingNavigationTrailingBar(),
        );
}
