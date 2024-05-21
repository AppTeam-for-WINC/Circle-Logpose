import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../app/facade/group_member_schedule_facade.dart';

import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../domain/model/schedule_response_params_model.dart';

import '../../../../../../../utils/schedule/schedule_response.dart';

import '../../../../../../notifiers/group_member_schedule_notifier.dart';

class AttendanceButton extends ConsumerWidget {
  const AttendanceButton({
    super.key,
    required this.isAttendance,
    required this.groupScheduleId,
    required this.groupSchedule,
  });
  final bool isAttendance;
  final String groupScheduleId;
  final GroupSchedule groupSchedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    Future<void> updateAttendance({required bool attendance}) async {
      final memberScheduleNotifier = ref.watch(
        groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
      );
      await memberScheduleNotifier.updateAttendance(attendance: attendance);
    }

    Future<void> updateResponse({
      required String memberScheduleId,
      required bool attendance,
    }) async {
      final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
      final scheduleParams = ScheduleResponseParams(
        memberScheduleId: memberScheduleId,
        attendance: !attendance,
        leaveEarly: false,
        lateness: false,
        absence: false,
      );
      await memberScheduleFacade.updateResponse(scheduleParams);
    }

    Future<void> onTap() async {
      final memberScheduleController =
          ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
      if (memberScheduleController == null) {
        return;
      }

      final attendance = memberScheduleController.attendance;

      await updateAttendance(attendance: attendance);
      await updateResponse(
        memberScheduleId: memberScheduleController.scheduleId,
        attendance: attendance,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: deviceWidth * 0.185,
        height: deviceHeight * 0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: isAttendance ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(ResponseType.attendance),
              ScheduleResponse.getText(ResponseType.attendance),
            ],
          ),
        ),
      ),
    );
  }
}
