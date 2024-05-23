import 'package:flutter/cupertino.dart';

import '../../../../../navigations/auth_navigation_leading_bar_navigator.dart';

class AuthNavigationLeadingBar extends StatelessWidget {
  const AuthNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    void handleToTap() {
      AuthNavigationLeadingBarNavigator(context).moveToPage();
    }

    return CupertinoButton(
      onPressed: handleToTap,
      child: const Icon(
        CupertinoIcons.back,
        size: 25,
        color: CupertinoColors.white,
      ),
    );
  }
}
