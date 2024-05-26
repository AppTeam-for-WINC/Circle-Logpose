import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/modals/user_setting_navigation_trailing_bar_modal_navigator.dart';

class UserSettingNavigationTrailingBar extends ConsumerWidget {
  const UserSettingNavigationTrailingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> showModal() async {
      final navigator = UserSettingNavigationTrailingBarModalNavigator(context);
      await navigator.showModal();
    }

    return CupertinoButton(
      onPressed: showModal,
      child: const Icon(
        CupertinoIcons.square_arrow_right,
        color: Color(0xFF7B61FF),
        size: 30,
      ),
    );
  }
}
