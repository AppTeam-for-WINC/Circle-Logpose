import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/group/group/group_membership_controller_provider.dart';
import '../../providers/group/schedule/group_member_schedule_controller_provider.dart';

class GroupMemberScheduleCreationHelper {
  const GroupMemberScheduleCreationHelper({required this.ref});
  final Ref ref;

  Future<void> createMemberSchedule(String scheduleId, String userId) async {
    try {
      final groupMemberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await groupMemberScheduleRepository.createMemberSchedule(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedule. ${e.message}');
    }
  }

  Future<void> createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    try {
      await _attemptToCreateAllMemberSchedule(groupId, scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedules. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: unexpected error occured. $e');
    }
  }

  Future<void> _attemptToCreateAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    final snapshot = await _fetchAllUserDocIdWithGroupId(groupId);
    await Future.wait(
      snapshot.map((userDocId) async {
        await createMemberSchedule(scheduleId, userDocId);
      }),
    );
  }

  Future<List<String>> _fetchAllUserDocIdWithGroupId(String groupId) async {
    try {
      final groupMembershipRepository =
          ref.read(groupMembershipRepositoryProvider);
      return groupMembershipRepository.fetchAllUserDocIdWithGroupId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch all user doc Id. ${e.message}');
    }
  }
}
