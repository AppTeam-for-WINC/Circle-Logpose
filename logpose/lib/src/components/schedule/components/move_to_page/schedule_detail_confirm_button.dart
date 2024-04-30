import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/group/schedule/group_member_schedule_provider.dart';
import '../../../../models/database/group/group_profile.dart';
import '../../../../models/database/group/group_schedule.dart';
import '../../../../utils/schedule/schedule_response.dart';
import '../../../popup/schedule_detail_confirm/schedule_detail_confirm.dart';

class ScheduleDetailConfirmButton extends ConsumerWidget {
  const ScheduleDetailConfirmButton({
    super.key,
    required this.groupScheduleId,
    required this.groupProfile,
    required this.groupSchedule,
  });
  final String groupScheduleId;
  final GroupProfile groupProfile;
  final GroupSchedule groupSchedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Future<void> onTap() async {
      await showCupertinoModalPopup<ScheduleDetailConfirm>(
        context: context,
        builder: (BuildContext context) {
          final schedule = ref.read(
            groupMemberScheduleProvider(groupScheduleId),
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
              responseIcon: ScheduleResponse.getIcon(ResponseType.leavingEarly),
              responseText: ScheduleResponse.getText(ResponseType.leavingEarly),
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

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: deviceWidth * 0.35,
            ),
            child: Text(
              groupSchedule.title,
              textAlign: TextAlign.end,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 20,
            color: Color(0xFF7B61FF),
          ),
        ],
      ),
    );
  }
}
