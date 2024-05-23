import 'package:flutter/cupertino.dart';

import 'components/account_id_setting_navigation_leading_bar.dart';

class AccountIdSettingNavigationBar extends CupertinoNavigationBar {
  const AccountIdSettingNavigationBar({super.key})
      : super(
          leading: const AccountIdSettinghNavigationLeadingBar(),
          backgroundColor: const Color.fromARGB(255, 245, 243, 254),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
        );
}
