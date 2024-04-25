import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../../services/database/member_schedule_controller.dart';

/// Create Group member's schedule.
class CreateMembersSchedule {
  CreateMembersSchedule._internal();
  static final CreateMembersSchedule _instance =
      CreateMembersSchedule._internal();
  static CreateMembersSchedule get instance => _instance;

  static Future<void> create({
    required String scheduleId,
    required String userId,
  }) async {
    try {
      // Create membership schedule by member.
      await GroupMemberScheduleController.create(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      debugPrint('Error: $e');
    }
  }
}
