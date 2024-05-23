import 'package:flutter/cupertino.dart';

import 'components/password_setting_navigation_leading_bar.dart';

class PasswordSettingNavigationBar extends CupertinoNavigationBar {
  const PasswordSettingNavigationBar({super.key})
      : super(
          leading: const PasswordSettingNavigationLeadingBar(),
          backgroundColor: const Color.fromARGB(255, 245, 243, 254),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
        );
}
