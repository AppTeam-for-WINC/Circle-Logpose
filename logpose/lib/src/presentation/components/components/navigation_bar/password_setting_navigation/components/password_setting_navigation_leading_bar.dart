import 'package:flutter/cupertino.dart';

import '../../../../../navigations/password_setting_navigation_leading_bar_navigator.dart';

class PasswordSettingNavigationLeadingBar extends StatelessWidget {
  const PasswordSettingNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = PasswordSettingNavigationLeadingBarNavigator(context);
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
