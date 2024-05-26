import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../handlers/user_setting_navigation_trailing_bar_dialog_handler.dart';
import '../../../../../../navigations/user_setting_navigation_trailing_bar_navigator.dart';

class UserSettingNavigationTrailingBarDialog extends ConsumerStatefulWidget {
  const UserSettingNavigationTrailingBarDialog({super.key});

  @override
  ConsumerState<UserSettingNavigationTrailingBarDialog> createState() =>
      _UserSettingNavigationTrailingBarDialogState();
}

class _UserSettingNavigationTrailingBarDialogState
    extends ConsumerState<UserSettingNavigationTrailingBarDialog> {
  @override
  Widget build(BuildContext context) {
    void popup() {
      UserSettingNavigationTrailingBarDialogNavigator(context).cancel();
    }

    Future<void> handleLogOut() async {
      final handler = UserSettingNavigationTrailingBarDialogHandler(
        context: context,
        ref: ref,
      );
      await handler.handleLogOut();
    }

    return CupertinoAlertDialog(
      title: const Text('ログアウトしますか?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: popup,
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: handleLogOut,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
