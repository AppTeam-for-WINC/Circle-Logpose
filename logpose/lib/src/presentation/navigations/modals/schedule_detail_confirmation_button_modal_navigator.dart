import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/group_profile.dart';
import '../../../domain/entity/group_schedule.dart';

import '../../../utils/schedule/schedule_response.dart';

import '../../components/components/popup/schedule_detail_confirm/schedule_detail_confirm.dart';

import '../../notifiers/group_member_schedule_notifier.dart';

class ScheduleDetailConfirmationButtonModalNavigator {
  ScheduleDetailConfirmationButtonModalNavigator({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.groupProfile,
    required this.groupSchedule,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupScheduleId;
  final GroupProfile groupProfile;
  final GroupSchedule groupSchedule;

  Future<void> showModal() async {
    await showCupertinoModalPopup<ScheduleDetailConfirm>(
      context: context,
      builder: (BuildContext context) {
        final schedule = ref.read(
          groupMemberScheduleNotifierProvider(groupScheduleId),
        );
        if (schedule == null) {
          return const SizedBox.shrink();
        }

        if (schedule.attendance) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.attendance),
            responseText: ScheduleResponse.getText(ResponseType.attendance),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.leaveEarly) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.leaveEarly),
            responseText: ScheduleResponse.getText(ResponseType.leaveEarly),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.lateness) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.lateness),
            responseText: ScheduleResponse.getText(ResponseType.lateness),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.absence) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.absence),
            responseText: ScheduleResponse.getText(ResponseType.absence),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else {
          return ScheduleDetailConfirm(
            responseIcon: null,
            responseText: null,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        }
      },
    );
  }
}
