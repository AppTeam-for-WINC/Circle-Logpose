import 'package:flutter/cupertino.dart';

import '../../../../../navigations/modals/user_setting_navigation_trailing_bar_modal_navigator.dart';

import '../../../../common/navigation_trailing_bar.dart';

class UserSettingNavigationTrailingBar extends StatelessWidget {
  const UserSettingNavigationTrailingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = UserSettingNavigationTrailingBarModalNavigator(context);
      await navigator.showModal();
    }

    return NavigationTrailingBar(
      iconColor: const Color(0xFF7B61FF),
      icon: CupertinoIcons.square_arrow_right,
      onPressed: handleToTap,
    );
  }
}
