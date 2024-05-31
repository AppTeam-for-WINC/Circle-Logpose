import 'package:flutter/cupertino.dart';

import '../../../../../navigations/modals/to_group_setting_navigation_trailing_bar_dialog_navigator.dart';

import '../../../../common/navigation_trailing_bar.dart';

class GroupSettingNavigationTrailingBar extends StatelessWidget {
  const GroupSettingNavigationTrailingBar({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator =
          ToGroupSettingNavigationTrailingBarDialogNavigator(context);
      await navigator.showModal(groupId);
    }

    return NavigationTrailingBar(
      iconColor: const Color(0xFF7B61FF),
      icon: CupertinoIcons.delete,
      onPressed: handleToTap,
    );
  }
}
