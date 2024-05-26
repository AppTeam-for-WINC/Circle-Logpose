import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_membership_facade.dart';

import '../../../domain/entity/group_membership.dart';
import '../../../domain/entity/user_profile.dart';

final groupMembershipManagementControllerProvider =
    Provider<GroupMembershipManagementController>(
  GroupMembershipManagementController.new,
);

class GroupMembershipManagementController {
  GroupMembershipManagementController(this.ref);

  final Ref ref;

  Future<String> fetchUserIdWithMembershipId(String membershipId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.fetchUserIdWithMembershipId(membershipId);
  }

  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.fetchAllUserDocIdWithGroupId(groupId);
  }

  Future<String> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String accountId,
  ) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.fetchMembershipIdWithGroupIdAndUserId(
      groupId,
      accountId,
    );
  }

  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.fetchAllMembershipIdList(groupId);
  }

  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> membershipIdList,
    String scheduleId,
  ) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.fetchUserProfilesNotAbsentList(
      membershipIdList,
      scheduleId,
    );
  }

  Stream<List<UserProfile?>> listenAllMember(String groupId) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade.listenAllMember(groupId);
  }

  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  ) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade.listenAllMembershipListWithUserId(userDocId);
  }

  Stream<List<String?>> listenAllMembershipIdList(String groupId) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade.listenAllMembershipIdList(groupId);
  }

  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade.listenAllAdminProfile(groupId);
  }

  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade.listenAllMembershipProfile(groupId);
  }

  Stream<List<UserProfile?>> listenAllMemberProfileNotAbsenceList(
    String scheduleId,
  ) async* {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    yield* groupMembershipFacade
        .listenAllMemberProfileNotAbsenceList(scheduleId);
  }

  Future<bool> doesMemberExist(String groupId, String userId) async {
    final groupMembershipFacade = ref.read(groupMembershipFacadeProvider);
    return groupMembershipFacade.doesMemberExist(groupId, userId);
  }
}
