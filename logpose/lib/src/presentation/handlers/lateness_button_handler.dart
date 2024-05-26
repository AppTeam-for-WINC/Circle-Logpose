import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../../domain/model/schedule_response_params_model.dart';

import '../../utils/schedule/schedule_response.dart';

import '../controllers/group_member_schedule/group_member_schedule_creation_and_update_controller.dart';
import '../navigations/modals/to_behind_and_early_setting_navigator.dart';
import '../notifiers/group_member_schedule_notifier.dart';

class LatenessButtonHandler {
  const LatenessButtonHandler({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.groupProfileAndScheduleAndId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupScheduleId;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;

  Future<void> handleLateness() async {
    final memberScheduleController =
        ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
    if (memberScheduleController == null) {
      return;
    }

    final lateness = memberScheduleController.lateness;
    final scheduleId = memberScheduleController.scheduleId;

    await _updateLateness(lateness: lateness);
    await _updateResponse(memberScheduleId: scheduleId, lateness: lateness);
    await _showModal();
  }

  Future<void> _updateLateness({required bool lateness}) async {
    final memberScheduleNotifier = ref.watch(
      groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
    );
    await memberScheduleNotifier.updateLateness(lateness: lateness);
  }

  Future<void> _updateResponse({
    required String memberScheduleId,
    required bool lateness,
  }) async {
    final responseController =
        ref.read(groupMemberScheduleCreationAndUpdateControllerProvider);
    final scheduleParams = ScheduleResponseParams(
      memberScheduleId: memberScheduleId,
      attendance: false,
      leaveEarly: false,
      lateness: !lateness,
      absence: false,
    );
    await responseController.updateResponse(scheduleParams);
  }

  Future<void> _showModal() async {
    final lateness = ref
        .read(groupMemberScheduleNotifierProvider(groupScheduleId))!
        .lateness;

    final navigator = ToBehindAndEarlySettingNavigator(context);
    await navigator.showModal(
      groupScheduleId: groupScheduleId,
      response: lateness,
      groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
      responseType: ResponseType.lateness,
    );
  }
}
