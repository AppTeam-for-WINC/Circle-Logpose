import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/database/user/user.dart';

import '../../../../server/database/group_schedule_controller.dart';
import '../../../../server/database/member_schedule_controller.dart';
import '../../../../server/database/user_controller.dart';

// Used with schedule_deleter_provider.
// Delete GroupSchedule, GroupMemberSchedule.
class ScheduleDeleter {
  const ScheduleDeleter();

  Future<void> delete(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    try {
      await _attemptToDelete(groupMemberList, groupScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete group schedule. Error: $e');
    }
  }

  Future<void> _attemptToDelete(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    await _deleteAllMemberSchedule(groupMemberList, groupScheduleId);
    await _deleteGroupSchedule(groupScheduleId);
  }

  Future<void> _deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    await Future.wait(
      groupMemberList.map((member) async {
        if (member == null) {
          debugPrint('Member is not existed.');
          return;
        }

        final memberScheduleId = await _fetchMemberScheduleId(
          member.accountId,
          groupScheduleId,
        );
        await _deleteMemberSchedule(memberScheduleId);
      }),
    );
  }

  Future<String> _fetchMemberScheduleId(
    String accountId,
    String groupScheduleId,
  ) async {
    try {
      return await _attemptToFetchMemberScheduleId(accountId, groupScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to read schedule ID and User ID. $e');
    }
  }

  Future<String> _attemptToFetchMemberScheduleId(
    String accountId,
    String groupScheduleId,
  ) async {
    final userDocId = await _fetchUserDocId(accountId);
    return GroupMemberScheduleController.fetchDocIdWithScheduleIdAndUserId(
      scheduleId: groupScheduleId,
      userDocId: userDocId,
    );
  }

  Future<String> _fetchUserDocId(String accountId) async {
    try {
      return await UserController.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> _deleteMemberSchedule(String memberScheduleId) async {
    try {
      await GroupMemberScheduleController.delete(memberScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member schedule. ${e.message}');
    }
  }

  Future<void> _deleteGroupSchedule(String groupScheduleId) async {
    try {
      await GroupScheduleController.delete(groupScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }
}
