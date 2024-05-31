import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_repository.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../entity/user_profile.dart';

import '../../interface/group/i_group_delete_use_case.dart';
import '../../interface/group_membership/i_group_member_delete_use_case.dart';
import '../../interface/group_membership/i_group_member_id_use_case.dart';
import '../../interface/group_schedule/i_group_schedule_delete_use_case.dart';

import '../../model/group_id_and_schedule_id_and_member_list_model.dart';

import '../usecase_group_membership/group_member_delete_use_case.dart';
import '../usecase_group_membership/group_member_id_use_case.dart';
import '../usecase_group_schedule/group_schedule_delete_use_case.dart';

final groupDeleteUseCaseProvider = Provider<IGroupDeleteUseCase>((ref) {
  final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);
  final memberDeleteUseCase = ref.read(groupMemberDeleteUseCaseProvider);
  final groupScheduleDeleteUseCase =
      ref.read(groupScheduleDeleteUseCaseProvider);
  final groupRepository = ref.read(groupRepositoryProvider);

  return GroupDeleteUseCase(
    groupMemberIdUseCase: groupMemberIdUseCase,
    memberDeleteUseCase: memberDeleteUseCase,
    groupScheduleDeleteUseCase: groupScheduleDeleteUseCase,
    groupRepository: groupRepository,
  );
});

class GroupDeleteUseCase implements IGroupDeleteUseCase {
  const GroupDeleteUseCase({
    required this.groupMemberIdUseCase,
    required this.memberDeleteUseCase,
    required this.groupScheduleDeleteUseCase,
    required this.groupRepository,
  });

  final IGroupMemberIdUseCase groupMemberIdUseCase;
  final IGroupMemberDeleteUseCase memberDeleteUseCase;
  final IGroupScheduleDeleteUseCase groupScheduleDeleteUseCase;
  final IGroupRepository groupRepository;

  @override
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
    await groupScheduleDeleteUseCase.deleteSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }

  Future<List<String>> _fetchAllMembershipIdList(String groupId) async {
    return groupMemberIdUseCase.fetchAllMembershipIdList(groupId);
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
    await memberDeleteUseCase.deleteMember(membershipDocId);
  }

  Future<void> _deleteGroup(String groupId) async {
    try {
      await groupRepository.delete(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. ${e.message}');
    }
  }
}
