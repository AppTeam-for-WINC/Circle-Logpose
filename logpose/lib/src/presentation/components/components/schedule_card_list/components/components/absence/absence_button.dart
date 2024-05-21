import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../app/facade/group_member_schedule_facade.dart';

import '../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../domain/model/schedule_response_params_model.dart';

import '../../../../../../../utils/schedule/schedule_response.dart';

import '../../../../../../notifiers/group_member_schedule_notifier.dart';

class AbsenceButton extends ConsumerWidget {
  const AbsenceButton({
    super.key,
    required this.isAbsence,
    required this.groupScheduleId,
    required this.groupSchedule,
  });
  final bool isAbsence;
  final String groupScheduleId;
  final GroupSchedule groupSchedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    Future<void> updateAbsence({required bool absence}) async {
      final memberScheduleNotifier = ref.watch(
        groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
      );
      await memberScheduleNotifier.updateAbsence(absence: absence);
    }

    Future<void> updateResponse({
      required String memberScheduleId,
      required bool absence,
    }) async {
      final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
      final scheduleParams = ScheduleResponseParams(
        memberScheduleId: memberScheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: false,
        absence: !absence,
      );
      await memberScheduleFacade.updateResponse(scheduleParams);
    }

    Future<void> onTap() async {
      final memberScheduleController =
          ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
      if (memberScheduleController == null) {
        return;
      }

      final absence = memberScheduleController.absence;

      await updateAbsence(absence: absence);
      await updateResponse(
        memberScheduleId: memberScheduleController.scheduleId,
        absence: absence,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: deviceWidth * 0.185,
        height: deviceHeight * 0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: isAbsence ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(ResponseType.absence),
              ScheduleResponse.getText(ResponseType.absence),
            ],
          ),
        ),
      ),
    );
  }
}
