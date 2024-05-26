import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../navigations/modals/to_group_setting_navigation_trailing_bar_dialog_navigator.dart';

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
      final navigator =
          ToGroupSettingNavigationTrailingBarDialogNavigator(context);
      await navigator.showModal(widget.groupId);
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
