import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/group_profile.dart';
import '../../../domain/entity/group_schedule.dart';

import '../../../utils/schedule_response.dart';

import '../../components/components/popup/schedule_detail_confirm/schedule_detail_confirm.dart';

import '../../notifiers/group_member_schedule_notifier.dart';

class ToScheduleDetailConfirmNavigator {
  ToScheduleDetailConfirmNavigator(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> showModal({
    required String groupScheduleId,
    required GroupProfile groupProfile,
    required GroupSchedule groupSchedule,
  }) async {
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
            responseIcon: ScheduleResponse.getIcon(ResponseType.attendance, 25),
            responseText: ScheduleResponse.getText(ResponseType.attendance, 18),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.leaveEarly) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.leaveEarly, 25),
            responseText: ScheduleResponse.getText(ResponseType.leaveEarly, 18),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.lateness) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.lateness, 25),
            responseText: ScheduleResponse.getText(ResponseType.lateness, 18),
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.absence) {
          return ScheduleDetailConfirm(
            responseIcon: ScheduleResponse.getIcon(ResponseType.absence, 25),
            responseText: ScheduleResponse.getText(ResponseType.absence, 18),
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
