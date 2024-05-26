import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_membership_facade.dart';

final groupMembershipDeletionControllerProvider =
    Provider<GroupMembershipDeletionController>(
  GroupMembershipDeletionController.new,
);

class GroupMembershipDeletionController {
  GroupMembershipDeletionController(this.ref);

  final Ref ref;

  Future<void> deleteMember(String membershipDocId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    await groupMembershipFacade.deleteMember(membershipDocId);
  }

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    await groupMembershipFacade.deleteMemberWithGroupIdAndAccountId(
      groupId,
      accountId,
    );
  }
}
