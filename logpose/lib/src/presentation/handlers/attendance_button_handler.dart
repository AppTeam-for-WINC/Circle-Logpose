import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/schedule_response_params_model.dart';

import '../controllers/group_member_schedule/group_member_schedule_creation_and_update_controller.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class AttendanceButtonHandler {
  const AttendanceButtonHandler({
    required this.ref,
    required this.groupScheduleId,
  });

  final WidgetRef ref;
  final String groupScheduleId;

  Future<void> handleAttendance() async {
    final memberScheduleController =
        ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return;
    }

    final attendance = memberScheduleController.attendance;
    final scheduleId = memberScheduleController.scheduleId;

    await _updateAttendance(attendance: attendance);
    await _updateResponse(memberScheduleId: scheduleId, attendance: attendance);
  }

  Future<void> _updateAttendance({required bool attendance}) async {
    final memberScheduleNotifier = ref
        .watch(groupMemberScheduleNotifierProvider(groupScheduleId).notifier);
    await memberScheduleNotifier.updateAttendance(attendance: attendance);
  }

  Future<void> _updateResponse({
    required String memberScheduleId,
    required bool attendance,
  }) async {
    final responseController =
        ref.read(groupMemberScheduleCreationAndUpdateControllerProvider);
    final scheduleParams = ScheduleResponseParams(
      memberScheduleId: memberScheduleId,
      attendance: !attendance,
      leaveEarly: false,
      lateness: false,
      absence: false,
    );
    await responseController.updateResponse(scheduleParams);
  }
}
