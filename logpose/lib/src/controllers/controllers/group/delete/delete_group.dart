import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logpose/src/services/database/group_controller.dart';
import 'package:logpose/src/services/database/group_membership_controller.dart';

import '../../../../models/database/user/user.dart';
import 'delete_schedule.dart';

// Delete Group, All GroupMembers, GroupSchedule, GroupMemberSchedule.
class DeleteGroup {
  DeleteGroup._internal();
  static final DeleteGroup _instance = DeleteGroup._internal();
  static DeleteGroup get instance => _instance;

  static Future<void> delete(
    String groupId,
    String? groupScheduleId,
    List<UserProfile?> groupMemberList,
  ) async {
    try {
      if (groupScheduleId != null) {
        await _deleteSchedule(groupId, groupScheduleId, groupMemberList);
      }
      final membershipIdList = await _fetchAllMembershipIdList(groupId);
      await _futureDeleteMember(membershipIdList);
      await _deleteGroup(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete group schedule. Error: $e');
    }
  }

  static Future<void> _deleteSchedule(
    String groupId,
    String groupScheduleId,
    List<UserProfile?> groupMemberList,
  ) async {
    await DeleteSchedule.delete(groupId, groupScheduleId, groupMemberList);
  }

  static Future<List<String>> _fetchAllMembershipIdList(String groupId) async {
    try {
      return await GroupMembershipController.watchAllMembershipIdList(groupId)
          .first;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to get all member ID list. $e');
    }
  }

  static Future<void> _futureDeleteMember(List<String> membershipIdList) async {
    await Future.wait(
      membershipIdList.map((membershipDocId) async {
        await _deleteMembers(membershipDocId);
      }),
    );
  }

  static Future<void> _deleteMembers(String membershipDocId) async {
    await GroupMembershipController.delete(membershipDocId);
  }

  static Future<void> _deleteGroup(String groupId) async {
    await GroupController.delete(groupId);
  }
}
