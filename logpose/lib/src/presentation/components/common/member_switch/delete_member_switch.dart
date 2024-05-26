import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/member_delete_switch.dart';

class MemberDeleteSwitch extends ConsumerWidget {
  const MemberDeleteSwitch({super.key, this.groupId, required this.mode});
  final String? groupId;
  final String mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleDeleteSwitch() async {
      final handler = MemberDeleteSwitchHandler(
        context: context,
        ref: ref,
        groupId: groupId,
        mode: mode,
      );
      await handler.handleDeleteSwitch();
    }

    return CupertinoButton(
      onPressed: handleDeleteSwitch,
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
