import 'package:flutter/cupertino.dart';

import '../../../../../navigations/to_user_setting_page_navigator.dart';

class AccountIdSettinghNavigationLeadingBar extends StatelessWidget {
  const AccountIdSettinghNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = ToUserSettingPageNavigator(context);
      await navigator.moveToPage();
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 15, top: 15),
      onPressed: handleToTap,
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }
}
