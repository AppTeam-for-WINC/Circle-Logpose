import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/mode/group_member_delete_mode_provider.dart';

class DeleteMemberSwitch extends ConsumerWidget {
  const DeleteMemberSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      ref.watch(groupMemberDeleteModeProvider.notifier).state =
          !ref.watch(groupMemberDeleteModeProvider);
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
