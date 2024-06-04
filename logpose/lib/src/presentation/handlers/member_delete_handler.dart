import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/group_membership/group_membership_deletion_controller.dart';

import '../controllers/group_membership/group_membership_management_controller.dart';
import '../notifiers/group_member_list_setter_notifier.dart';
import '../notifiers/search_user_notifier.dart';

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
    final membershipId = await _fetchMembershipId();
    if (membershipId == null) {
      _removeMember();
      return;
    }

    _removeMemberState();
    await _deleteMemberWithMembershipId(membershipId);
  }

  Future<String?> _fetchMembershipId() async {
    final membershipController =
        ref.read(groupMembershipManagementControllerProvider);
    return membershipController.fetchMembershipIdWithGroupIdAndAccountId(
      groupId!,
      accountId,
    );
  }

  Future<void> _deleteMemberWithMembershipId(String membershipId) async {
    final membershipDeletionController =
        ref.read(groupMembershipDeletionControllerProvider);
    await membershipDeletionController.deleteMember(membershipId);
  }

  void _removeMember() {
    ref
        .read(groupMemberListSetterNotifierProvider.notifier)
        .removeMember(accountId);
    _removeMemberState();
  }

  void _removeMemberState() {
    ref
        .read(searchUserNotifierProvider(groupId).notifier)
        .removeMemberState(accountId);
  }
}
