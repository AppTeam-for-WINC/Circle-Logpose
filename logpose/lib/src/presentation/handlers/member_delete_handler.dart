import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/group_membership/group_membership_deletion_controller.dart';
import '../notifiers/search_user_notifier_provider.dart';
import '../notifiers/set_group_member_list_notifier.dart';

class MemberDeleteHandler {
  MemberDeleteHandler({
    required this.ref,
    required this.groupId,
    required this.accountId,
  });

  final WidgetRef ref;
  final String? groupId;
  final String accountId;

  Future<void> handleToDeleteMember() async {
    if (groupId != null) {
      await _deleteMember();
    } else {
      _removeMember();
    }
  }

  Future<void> _deleteMember() async {
    final memberController =
        ref.read(groupMembershipDeletionControllerProvider);
    await memberController.deleteMemberWithGroupIdAndAccountId(
      groupId!,
      accountId,
    );
  }

  void _removeMember() {
    ref
        .watch(setGroupMemberListNotifierProvider.notifier)
        .removeMember(accountId);
    ref.watch(searchUserNotifierProvider(groupId).notifier).removeMemberState();
  }
}
