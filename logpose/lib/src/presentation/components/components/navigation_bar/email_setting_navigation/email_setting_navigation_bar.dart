import 'package:flutter/cupertino.dart';

import 'components/email_setting_navigation_leading_bar.dart';

class EmailSettingNavigationBar extends CupertinoNavigationBar {
  const EmailSettingNavigationBar({super.key})
      : super(
          leading: const EmailSettingNavigationLeadingBar(),
          backgroundColor: const Color.fromARGB(255, 245, 243, 254),
          border: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(0, 0, 0, 0),
            ),
          ),
        );
}
