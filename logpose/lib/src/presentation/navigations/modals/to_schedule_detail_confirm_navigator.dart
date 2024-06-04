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
            responseType: ResponseType.attendance,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.leaveEarly) {
          return ScheduleDetailConfirm(
            responseType: ResponseType.leaveEarly,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.lateness) {
          return ScheduleDetailConfirm(
            responseType: ResponseType.lateness,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else if (schedule.absence) {
          return ScheduleDetailConfirm(
            responseType: ResponseType.absence,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        } else {
          return ScheduleDetailConfirm(
            responseType: null,
            group: groupProfile,
            scheduleId: groupScheduleId,
            schedule: groupSchedule,
          );
        }
      },
    );
  }
}
