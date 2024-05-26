import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/member_delete_controller.dart';
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
    final memberController = ref.read(memberDeleteControllerProvider);
    await memberController.deleteMember(groupId!, accountId);
  }

  void _removeMember() {
    ref
        .watch(setGroupMemberListNotifierProvider.notifier)
        .removeMember(accountId);
  }
}
