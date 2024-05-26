import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_membership_facade.dart';

import '../../../domain/entity/user_profile.dart';

final groupMembershipCreationAndUpdateControllerProvider =
    Provider<GroupMembershipCreationAndUpdateController>(
  GroupMembershipCreationAndUpdateController.new,
);

class GroupMembershipCreationAndUpdateController {
  GroupMembershipCreationAndUpdateController(this.ref);

  final Ref ref;

  Future<void> createAdminRole(String userDocId, String groupId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    await groupMembershipFacade.createAdminRole(userDocId, groupId);
  }

  Future<void> createMembershipRole(String memberDocId, String groupId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    await groupMembershipFacade.createMembershipRole(memberDocId, groupId);
  }

  Future<void> createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    await groupMembershipFacade.createAllMembershipRole(groupId, memberList);
  }
}
