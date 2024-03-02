import 'package:firebase_core/firebase_core.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';

class UpdateGroupMemberSchedule {
  UpdateGroupMemberSchedule._internal();
  static final UpdateGroupMemberSchedule _instance =
      UpdateGroupMemberSchedule._internal();
  static UpdateGroupMemberSchedule get instance => _instance;

  static Future<void> update({
    required String scheduleId,
    bool? attendance,
    bool? leaveEarly,
    bool? lateness,
    bool? absence,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    try {
      final userDocId = await AuthController.getCurrentUserId();
      if (userDocId == null) {
        throw Exception('User not logged in.');
      }
      final docId = await _readDocId(scheduleId, userDocId);
      if (docId == null) {
        return;
      }
      await GroupMemberScheduleController.update(
        docId: docId,
        attendance: attendance,
        leaveEarly: leaveEarly,
        lateness: lateness,
        absence: absence,
        startAt: startAt,
        endAt: endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Failed to update database. $e');
    }
  }

  static Future<String?> _readDocId(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final docId =
          await GroupMemberScheduleController.readDocIdWithScheduleIdAndUserId(
        scheduleId: scheduleId,
        userDocId: userDocId,
      );
      return docId;
    } on FirebaseException catch (e) {
      throw Exception('Failed to read Doc ID. $e');
    }
  }
}
