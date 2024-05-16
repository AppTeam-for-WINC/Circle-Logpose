import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/database/user/user.dart';

import '../providers/group/group/group_member_creation_helper_provider.dart';
import '../providers/group/group/group_membership_controller_provider.dart';
import '../providers/group/members/group_member_deleter_provider.dart';
import '../providers/group/role/group_role_profile_stream_provider.dart';
import '../providers/group/schedule/group_schedule_controller_provider.dart';

import 'helper/group_member_creation_helper.dart';
import 'helper/group_member_delete_helper.dart';
import 'helper/group_member_fetcher_helper.dart';
import 'helper/group_role_profile_listen_helper.dart';

final groupMembershipUseCaseProvider = Provider<GroupMembershipUseCase>(
  (ref) => GroupMembershipUseCase(ref: ref),
);

class GroupMembershipUseCase {
  GroupMembershipUseCase({required this.ref})
      : _groupMemberCreationHelper =
            ref.read(groupMemberCreationHelperProvider),
        _groupMemberFetcherHelper = ref.read(groupMemberFetcherHelperProvider),
        _groupRoleProfileListenHelper =
            ref.read(groupRoleProfileListenHelperProvider),
        _groupMemberDeleteHelper = ref.read(groupMemberDeleteHelperProvider);

  final Ref ref;
  final GroupMemberCreationHelper _groupMemberCreationHelper;
  final GroupMemberFetcherHelper _groupMemberFetcherHelper;
  final GroupRoleProfileListenHelper _groupRoleProfileListenHelper;
  final GroupMemberDeleteHelper _groupMemberDeleteHelper;

  Future<void> createAdminRole(String userDocId, String groupId) async {
    await _groupMemberCreationHelper.createAdminRole(userDocId, groupId);
  }

  Future<void> createMembershipRole(
    String memberDocId,
    String groupId,
  ) async {
    await _groupMemberCreationHelper.createMembershipRole(memberDocId, groupId);
  }

  Future<void> createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    await _groupMemberCreationHelper.createAllMembershipRole(
      groupId,
      memberList,
    );
  }

  Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
    try {
      final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
      return await groupScheduleRepository.fetchGroupId(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }

  Future<List<String>> fetchAllMembershipIdList(String groupId) async {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      return await memberRepository.listenAllMembershipIdList(groupId).first;
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch all member ID list. ${e.message}',
      );
    }
  }

  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> userIdList,
    String scheduleId,
  ) async {
    return _groupMemberFetcherHelper.fetchUserProfilesNotAbsentList(
      userIdList,
      scheduleId,
    );
  }

  Stream<List<UserProfile?>> listenAllMember(String groupId) async* {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      yield* memberRepository.listenAllMember(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error to watch membership profile. $e');
    }
  }

  Stream<List<String?>> listenAllMembershipIdList(String groupId) async* {
    final memberRepository = ref.read(groupMembershipRepositoryProvider);
    yield* memberRepository.listenAllMembershipIdList(groupId);
  }

  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId) async* {
    yield* _groupRoleProfileListenHelper.listenAllAdminProfile(groupId);
  }

  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId) async* {
    yield* _groupRoleProfileListenHelper.listenAllMembershipProfile(groupId);
  }

  Future<void> deleteMember(String membershipDocId) async {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      await memberRepository.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  ) async {
    try {
      await _groupMemberDeleteHelper.deleteMemberWithGroupIdAndAccountId(
        groupId,
        accountId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }

  Future<bool> doesMemberExist(String groupId, String userId) async {
    final membershipRepository = ref.read(groupMembershipRepositoryProvider);
    return membershipRepository.doesMemberExist(
      groupId: groupId,
      userDocId: userId,
    );
  }
}
