import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/group_membership.dart';
import '../../entity/user_profile.dart';

import '../usecase_group_membership/group_member_creation_use_case.dart';
import '../usecase_group_membership/group_member_delete_use_case.dart';
import '../usecase_group_membership/group_member_exist_use_case.dart';
import '../usecase_group_membership/group_member_id_listen_use_case.dart';
import '../usecase_group_membership/group_member_id_use_case.dart';
import '../usecase_group_membership/group_member_listen_by_role_use_case.dart';
import '../usecase_group_membership/group_member_listen_not_absence_liste_use_case.dart';
import '../usecase_group_membership/group_member_listen_use_case.dart';
import '../usecase_group_membership/group_member_use_case.dart';

final groupMembershipFacadeProvider = Provider<GroupMembershipFacade>(
  (ref) => GroupMembershipFacade(ref: ref),
);

class GroupMembershipFacade {
  GroupMembershipFacade({required this.ref})
      : _groupMemberCreationUseCase =
            ref.read(groupMemberCreationUseCaseProvider),
        _groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider),
        _groupMemberUseCase = ref.read(groupMemberUseCaseProvider),
        _groupMemberIdListenUseCase =
            ref.read(groupMemberIdListenUseCaseProvider),
        _groupMemberListenUseCase = ref.read(groupMemberListenUseCaseProvider),
        _groupMemberListenByRoleUseCase =
            ref.read(groupMemberListenByRoleUseCaseProvider),
        _groupMemberListenNotAbsenceUseCase =
            ref.read(groupMemberListenNotAbsenceUseCaseProvider),
        _groupMemberDeleteUseCase = ref.read(groupMemberDeleteUseCaseProvider),
        _groupMemberExistUseCase = ref.read(groupMemberExistUseCaseProvider);

  final Ref ref;
  final GroupMemberCreationUseCase _groupMemberCreationUseCase;
  final GroupMemberIdUseCase _groupMemberIdUseCase;
  final GroupMemberUseCase _groupMemberUseCase;
  final GroupMemberIdListenUseCase _groupMemberIdListenUseCase;
  final GroupMemberListenUseCase _groupMemberListenUseCase;
  final GroupMemberListenByRoleUseCase _groupMemberListenByRoleUseCase;
  final GroupMemberListenNotAbsenceUseCase _groupMemberListenNotAbsenceUseCase;
  final GroupMemberDeleteUseCase _groupMemberDeleteUseCase;
  final GroupMemberExistUseCase _groupMemberExistUseCase;

  Future<void> createAdminRole(String userDocId, String groupId) async {
    await _groupMemberCreationUseCase.createAdminRole(userDocId, groupId);
  }

  Future<void> createMembershipRole(
    String memberDocId,
    String groupId,
  ) async {
    await _groupMemberCreationUseCase.createMembershipRole(
      memberDocId,
      groupId,
    );
  }

  Future<void> createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    await _groupMemberCreationUseCase.createAllMembershipRole(
      groupId,
      memberList,
    );
  }

  Future<String> fetchUserIdWithMembershipId(String membershipId) async {
    return _groupMemberIdUseCase.fetchUserIdWithMembershipId(membershipId);
  }

  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userId,
  ) async {
    return _groupMemberIdUseCase.fetchUserIdWithScheduleIdAndUserIdByTerm(
      scheduleId,
      userId,
    );
  }

  Future<String> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String accountId,
  ) async {
    return _groupMemberIdUseCase.fetchMembershipIdWithGroupIdAndUserId(
      groupId,
      accountId,
    );
  }

  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    return _groupMemberIdUseCase.fetchAllMembershipIdList(groupId);
  }

  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> membershipIdList,
    String scheduleId,
  ) async {
    return _groupMemberUseCase.fetchUserProfilesNotAbsentList(
      membershipIdList,
      scheduleId,
    );
  }

  Stream<List<UserProfile?>> listenAllMember(String groupId) async* {
    yield* _groupMemberListenUseCase.listenAllMember(groupId);
  }

  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  ) async* {
    yield* _groupMemberListenUseCase.listenAllMembershipListWithUserId(
      userDocId,
    );
  }

  Stream<List<String?>> listenAllMembershipIdList(String groupId) async* {
    yield* _groupMemberIdListenUseCase.listenAllMembershipIdList(groupId);
  }

  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId) async* {
    yield* _groupMemberListenByRoleUseCase.listenAllAdminProfile(groupId);
  }

  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId) async* {
    yield* _groupMemberListenByRoleUseCase.listenAllMembershipProfile(groupId);
  }

  Stream<List<UserProfile?>> listenAllMemberProfileNotAbsenceList(
    String scheduleId,
  ) async* {
    yield* _groupMemberListenNotAbsenceUseCase
        .listenAllMemberProfileNotAbsenceList(
      scheduleId,
    );
  }

  Future<void> deleteMember(String membershipDocId) async {
    await _groupMemberDeleteUseCase.deleteMember(membershipDocId);
  }

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    await _groupMemberDeleteUseCase.deleteMemberWithGroupIdAndAccountId(
      groupId,
      accountId,
    );
  }

  Future<bool> doesMemberExist(String groupId, String userId) async {
    return _groupMemberExistUseCase.doesMemberExist(groupId, userId);
  }
}
