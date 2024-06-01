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
    Future<void> handleLogOut() async {
      final handler = UserSettingNavigationTrailingBarDialogHandler(
        context: context,
        ref: ref,
      );
      await handler.handleLogOut();
    }
    
    void cancel() {
      UserSettingNavigationTrailingBarDialogNavigator(context).cancel();
    }

    return CupertinoAlertDialog(
      title: const Text('ログアウトしますか?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: handleLogOut,
          child: const Text('Yes'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: cancel,
          child: const Text('No'),
        ),
      ],
    );
  }
}
