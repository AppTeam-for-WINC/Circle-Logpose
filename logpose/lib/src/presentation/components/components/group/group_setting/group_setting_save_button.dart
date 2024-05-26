import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/group_setting_save_button_handler.dart';

class GroupSettingSaveButton extends ConsumerStatefulWidget {
  const GroupSettingSaveButton({
    super.key,
    required this.groupId,
    required this.groupName,
  });
  final String groupId;
  final String groupName;

  @override
  ConsumerState<GroupSettingSaveButton> createState() =>
      _GroupSettingSaveButtonState();
}

class _GroupSettingSaveButtonState
    extends ConsumerState<GroupSettingSaveButton> {
  @override
  Widget build(BuildContext context) {
    Future<void> handleSave() async {
      final handler = GroupSettingSaveButtonHandler(
        context: context,
        ref: ref,
        groupId: widget.groupId,
        groupName: widget.groupName,
      );
      await handler.handleSave();
    }

    return CupertinoButton(
      onPressed: handleSave,
      color: const Color(0xFF7B61FF),
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: 117,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(0, 0, 0, 0),
              ),
              child: const Icon(
                CupertinoIcons.check_mark,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Text('変更を保存'),
          ],
        ),
      ),
    );
  }
}
