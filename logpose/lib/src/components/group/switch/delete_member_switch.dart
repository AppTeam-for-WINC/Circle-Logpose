import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/components/popup/delete_member_list/delete_member_list.dart';

import '../../../controllers/providers/group/mode/group_member_delete_mode_provider.dart';

/// Select mode which is create or setting.
class DeleteMemberSwitch extends ConsumerWidget {
  const DeleteMemberSwitch({super.key, this.groupId, required this.mode});
  final String? groupId;
  final String mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onPressed() async {
      if (mode == 'create') {
        ref.watch(groupMemberDeleteModeProvider.notifier).state =
            !ref.watch(groupMemberDeleteModeProvider);
      } else if (mode == 'setting') {
        ref.watch(groupMemberDeleteModeProvider.notifier).state = true;
        await showCupertinoModalPopup<DeleteMemberList>(
          context: context,
          builder: (BuildContext context) {
            return DeleteMemberList(groupId: groupId!);
          },
        );
        return;
      } else {
        debugPrint('Please set another mode.');
        return;
      }
    }

    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFEB6161),
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.person_badge_minus_fill,
            size: 20,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
