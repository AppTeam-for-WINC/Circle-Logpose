import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';
import '../../../../../models/database/group/group_schedule.dart';
import '../../../../../utils/schedule/schedule_response.dart';

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

    Future<void> onTap() async {
      final schedule = ref.read(groupMemberScheduleProvider(groupScheduleId));
      if (schedule == null) {
        return;
      }
      await ref
          .watch(groupMemberScheduleProvider(groupScheduleId).notifier)
          .updateAttendance(attendance: schedule.attendance);
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
