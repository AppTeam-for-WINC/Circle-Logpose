import 'package:flutter/cupertino.dart';

import '../../../../../navigations/pop_navigator.dart';

class AuthNavigationLeadingBar extends StatelessWidget {
  const AuthNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    void handleToTap() {
      PopNavigator(context).pop();
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
