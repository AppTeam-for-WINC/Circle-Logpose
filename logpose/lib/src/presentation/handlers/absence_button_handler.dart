import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/schedule_response_params_model.dart';

import '../controllers/response_button_controller.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class AbsenceButtonHandler {
  const AbsenceButtonHandler({
    required this.ref,
    required this.groupScheduleId,
  });

  final WidgetRef ref;
  final String groupScheduleId;

  Future<void> handleAbsence() async {
    final memberScheduleController =
        ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return;
    }

    final absence = memberScheduleController.absence;
    final scheduleId = memberScheduleController.scheduleId;

    await _updateAbsence(absence: absence);
    await _updateResponse(memberScheduleId: scheduleId, absence: absence);
  }

  Future<void> _updateAbsence({required bool absence}) async {
    final memberScheduleNotifier = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
    );
    await memberScheduleNotifier.updateAbsence(absence: absence);
  }

  Future<void> _updateResponse({
    required String memberScheduleId,
    required bool absence,
  }) async {
    final responseController = ref.read(responseButtonControllerProvider);
      final scheduleParams = ScheduleResponseParams(
        memberScheduleId: memberScheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: false,
        absence: !absence,
      );
    await responseController.updateResponse(scheduleParams);
  }
}
