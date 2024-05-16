import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../providers/group/schedule/group_schedule_controller_provider.dart';

import '../group_member_schedule_use_case.dart';

final groupScheduleDeleteHelperProvider = Provider<GroupScheduleDeleteHelper>(
  (ref) => GroupScheduleDeleteHelper(ref: ref),
);

class GroupScheduleDeleteHelper {
  const GroupScheduleDeleteHelper({required this.ref});
  final Ref ref;

  Future<void> deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    try {
      final memberScheduleUseCase =
          ref.read(groupMemberScheduleUseCaseProvider);
      await memberScheduleUseCase.deleteAllMemberSchedule(
        groupMemberList,
        groupScheduleId,
      );
      await _deleteGroupSchedule(groupScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }

  Future<void> _deleteGroupSchedule(String groupScheduleId) async {
    try {
      final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
      await scheduleRepository.delete(groupScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group schedule. ${e.message}');
    }
  }
}
