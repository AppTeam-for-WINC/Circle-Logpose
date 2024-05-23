import 'package:flutter/cupertino.dart';

import '../../../../../navigations/user_setting_navigation_leading_bar_navigator.dart';

class UserSettingNavigationLeadingBar extends StatelessWidget {
  const UserSettingNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = UserSettingNavigationLeadingBarNavigator(context);
      await navigator.moveToPage();
    }

    return CupertinoButton(
      onPressed: handleToTap,
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }
}
