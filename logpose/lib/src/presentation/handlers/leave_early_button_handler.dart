import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../../domain/model/schedule_response_params_model.dart';

import '../../utils/schedule/schedule_response.dart';

import '../controllers/group_member_schedule/group_member_schedule_creation_and_update_controller.dart';
import '../navigations/modals/to_behind_and_early_setting_navigator.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class LeaveEarlyButtonHandler {
  const LeaveEarlyButtonHandler({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.groupProfileAndScheduleAndId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupScheduleId;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;

  Future<void> handleLeaveEarly() async {
    final memberScheduleController =
        ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return;
    }

    final leaveEarly = memberScheduleController.leaveEarly;
    final scheduleId = memberScheduleController.scheduleId;

    await _updateLeaveEarly(leaveEarly: leaveEarly);
    await _updateResponse(memberScheduleId: scheduleId, leaveEarly: leaveEarly);
    await _showModal();
  }

  Future<void> _updateLeaveEarly({required bool leaveEarly}) async {
    final memberScheduleNotifier = ref
        .watch(groupMemberScheduleNotifierProvider(groupScheduleId).notifier);
    await memberScheduleNotifier.updateLeaveEarly(leaveEarly: leaveEarly);
  }

  Future<void> _updateResponse({
    required String memberScheduleId,
    required bool leaveEarly,
  }) async {
    final responseController =
        ref.read(groupMemberScheduleCreationAndUpdateControllerProvider);
    final scheduleParams = ScheduleResponseParams(
      memberScheduleId: memberScheduleId,
      attendance: false,
      leaveEarly: !leaveEarly,
      lateness: false,
      absence: false,
    );
    await responseController.updateResponse(scheduleParams);
  }

  Future<void> _showModal() async {
    // ref.read()におけるデータの変更が即座に反映されないため、再度呼び出している。
    final leaveEarly = ref
        .read(groupMemberScheduleNotifierProvider(groupScheduleId))!
        .leaveEarly;

    final navigator = ToBehindAndEarlySettingNavigator(context);
    await navigator.showModal(
      groupScheduleId: groupScheduleId,
      response: leaveEarly,
      groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
      responseType: ResponseType.leaveEarly,
    );
  }
}
