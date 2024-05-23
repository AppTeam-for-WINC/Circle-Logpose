import 'package:flutter/cupertino.dart';

import '../../../../../navigations/email_setting_navigation_leading_bar_navigator.dart';

class EmailSettingNavigationLeadingBar extends StatelessWidget {
  const EmailSettingNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = EmailSettingNavigationLeadingBarNavigator(context);
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
