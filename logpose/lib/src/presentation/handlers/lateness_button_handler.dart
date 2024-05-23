import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../../domain/model/schedule_response_params_model.dart';

import '../../utils/schedule/schedule_response.dart';

import '../controllers/response_button_controller.dart';
import '../navigations/modals/leave_early_and_lateness_button_modal_navigator.dart';
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
    final responseController = ref.read(responseButtonControllerProvider);
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

    final navigator = LeaveEalryAndLatenessButtonModalNavigator(
      context: context,
      ref: ref,
      groupScheduleId: groupScheduleId,
      response: lateness,
      groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
      responseType: ResponseType.lateness,
    );
    await navigator.showModal();
  }
}
