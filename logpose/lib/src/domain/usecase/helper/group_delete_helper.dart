import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_id_and_schedule_id_and_member_list_model.dart';
import '../../../models/database/user/user.dart';

import '../../providers/group/group/group_controller_provider.dart';

import '../group_membership_use_case.dart';
import '../group_schedule_use_case.dart';

final groupDeleteHelperProvider = Provider<GroupDeleteHelper>(
  (ref) => GroupDeleteHelper(ref: ref),
);

class GroupDeleteHelper {
  const GroupDeleteHelper({required this.ref});
  final Ref ref;

  Future<void> deleteGroup(GroupIdAndScheduleIdAndMemberList groupData) async {
    try {
      await _attemptToDelete(groupData);
    } on Exception catch (e) {
      throw Exception('Failed to delete group schedule. Error: $e');
    }
  }

  Future<void> _attemptToDelete(
    GroupIdAndScheduleIdAndMemberList groupData,
  ) async {
    final groupId = groupData.groupId;
    final groupScheduleId = groupData.groupScheduleId;
    final groupMemberList = groupData.groupMemberList;

    if (groupScheduleId != null) {
      await _deleteSchedule(groupMemberList, groupScheduleId);
    }

    final membershipIdList = await _fetchAllMembershipIdList(groupId);
    await _deleteMemberList(membershipIdList);

    await _deleteGroup(groupId);
  }

  Future<void> _deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    try {
      final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);
      await groupScheduleUseCase.deleteSchedule(
        groupMemberList,
        groupScheduleId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }

  Future<List<String>> _fetchAllMembershipIdList(String groupId) async {
    final memberUseCase = ref.read(groupMembershipUseCaseProvider);
    return memberUseCase.fetchAllMembershipIdList(groupId);
  }

  Future<void> _deleteMemberList(List<String> membershipIdList) async {
    try {
      await Future.wait(
        membershipIdList.map((membershipDocId) async {
          await _deleteMember(membershipDocId);
        }),
      );
    } on Exception catch (e) {
      throw Exception('Error: unexpected error occured. $e');
    }
  }

  Future<void> _deleteMember(String membershipDocId) async {
    final memberUseCase = ref.read(groupMembershipUseCaseProvider);
    await memberUseCase.deleteMember(membershipDocId);
  }

  Future<void> _deleteGroup(String groupId) async {
    try {
      final groupRepository = ref.read(groupRepositoryProvider);
      await groupRepository.delete(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. ${e.message}');
    }
  }
}
