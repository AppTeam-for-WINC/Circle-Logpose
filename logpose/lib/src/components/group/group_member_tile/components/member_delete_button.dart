import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/group/members/membership/set_group_member_list_provider.dart';
import '../../../../domain/usecase/group_membership_use_case.dart';

class MemberDeleteButton extends ConsumerWidget {
  const MemberDeleteButton({super.key, required this.accountId, this.groupId});
  final String accountId;
  final String? groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onPressed() async {
      if (groupId != null) {
        await ref
            .read(groupMembershipUseCaseProvider)
            .deleteMemberWithGroupIdAndAccountId(
              groupId!,
              accountId,
            );
      }
      ref.watch(setGroupMemberListProvider.notifier).removeMember(accountId);
    }

    return CupertinoButton(
      onPressed: onPressed,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 231, 231, 231),
          borderRadius: BorderRadius.all(Radius.circular(999)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Icon(CupertinoIcons.delete, color: CupertinoColors.black),
      ),
    );
  }
}
