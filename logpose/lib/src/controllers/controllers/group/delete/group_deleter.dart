import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/custom/group_id_and_schedule_id_and_member_list_model.dart';
import '../../../../models/database/user/user.dart';

import '../../../../server/database/group_controller.dart';
import '../../../../server/database/group_membership_controller.dart';

import 'schedule_deleter.dart';

// Used with group_deleter_provider
// Delete Group, All GroupMembers, GroupSchedule, GroupMemberSchedule.
class GroupDeleter {
  const GroupDeleter();

  Future<void> delete(GroupIdAndScheduleIdAndMemberList groupData) async {
    try {
      await _attemptToDelete(groupData);
    } on FirebaseException catch (e) {
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

    final membershipIdList = await _fetchAllMembershipIdListOfFirst(groupId);
    await _deleteMemberList(membershipIdList);

    await _deleteGroup(groupId);
  }

  Future<void> _deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    try {
      await const ScheduleDeleter().delete(
        groupMemberList,
        groupScheduleId,
      );
    } on Exception catch (e) {
      throw Exception('Error: failed to delete group schedule. $e');
    }
  }

  Future<List<String>> _fetchAllMembershipIdListOfFirst(String groupId) async {
    try {
      return await GroupMembershipController.watchAllMembershipIdList(groupId)
          .first;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to get all member ID list. ${e.message}');
    }
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
    try {
      await GroupMembershipController.delete(membershipDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member. ${e.message}');
    }
  }

  Future<void> _deleteGroup(String groupId) async {
    try {
      await GroupController.delete(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. ${e.message}');
    }
  }
}
