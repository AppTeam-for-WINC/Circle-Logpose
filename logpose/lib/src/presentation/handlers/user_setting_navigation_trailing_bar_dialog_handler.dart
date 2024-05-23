import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/log_out_controller.dart';
import '../navigations/user_setting_navigation_trailing_bar_navigator.dart';

class UserSettingNavigationTrailingBarDialogHandler {
  UserSettingNavigationTrailingBarDialogHandler({
    required this.context,
    required this.ref,
  });

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleLogOut() async {
    await _logout();
    await _moveToPage();
  }

  Future<void> _logout() async {
    final logOutController = ref.read(logOutControllerProvider);
    await logOutController.logOut();
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      final navigator =
          UserSettingNavigationTrailingBarDialogNavigator(context);
      await navigator.moveToPage();
    }
  }
}
