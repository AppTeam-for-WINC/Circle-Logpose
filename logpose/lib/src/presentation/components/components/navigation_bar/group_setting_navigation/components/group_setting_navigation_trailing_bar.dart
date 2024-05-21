import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/modals/group_setting_navigation_trailing_bar_modal_navigator.dart';

class GroupSettingNavigationTrailingBar extends ConsumerStatefulWidget {
  const GroupSettingNavigationTrailingBar({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<GroupSettingNavigationTrailingBar> createState() =>
      _GroupSettingNavigationTrailingBarState();
}

class _GroupSettingNavigationTrailingBarState
    extends ConsumerState<GroupSettingNavigationTrailingBar> {
  @override
  Widget build(BuildContext context) {
    Future<void> showModal() async {
      final navigator = GroupSettingNavigationTrailingBarModalNavigator(
        context,
        widget.groupId,
      );
      await navigator.showModal();
    }

    return CupertinoButton(
      onPressed: showModal,
      child: const Icon(
        CupertinoIcons.delete,
        color: Color(0xFF7B61FF),
        size: 25,
      ),
    );
  }
}
