import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../handlers/group_setting_navigation_trailing_bar_dialog_handler.dart';
import '../../../../../navigations/group_setting_navigation_trailing_bar_dialog_navigator.dart';

class GroupSettingNavigationTrailingBarDialog extends ConsumerStatefulWidget {
  const GroupSettingNavigationTrailingBarDialog({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  ConsumerState<GroupSettingNavigationTrailingBarDialog> createState() =>
      _GroupSettingNavigationTrailingBarDialogState();
}

class _GroupSettingNavigationTrailingBarDialogState
    extends ConsumerState<GroupSettingNavigationTrailingBarDialog> {
  @override
  Widget build(BuildContext context) {
    Future<void> delete() async {
      final handler = GroupSettingNavigationTrailingBarDialogHandler(
        context,
        ref,
        widget.groupId,
      );

      await handler.handleToDelete();
    }

    void cancel() {
      GroupSettingNavigationTrailingBarDialogNavigator(context).cancel();
    }

    return CupertinoAlertDialog(
      title: const Text('団体を削除しますか?'),
      content: const Text('削除後、元に戻すことはできません。'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: delete,
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
