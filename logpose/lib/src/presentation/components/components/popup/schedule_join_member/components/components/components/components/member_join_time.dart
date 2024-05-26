import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../domain/entity/group_member_schedule.dart';
import '../../../../../../../../../domain/providers/group/schedule/listen_responesd_group_member_schedule_provider.dart';

import '../../../../../../../../../utils/time/time_utils.dart';

class MemberJoinTime extends ConsumerWidget {
  const MemberJoinTime({
    super.key,
    required this.scheduleId,
    required this.accountId,
  });

  final String scheduleId;
  final String accountId;

  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMemberSchedule = ref.watch(
      listenResponsedGroupMemberScheduleProvider(
        (scheduleId: scheduleId, accountId: accountId),
      ),
    );

    Widget buildTimeView(DateTime dateTime) {
      return Text(
        _formatDateTimeExcYear(dateTime),
        style: const TextStyle(fontSize: 12),
      );
    }

    Widget buildDivision() {
      return const Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Text('|', style: TextStyle(fontSize: 9)),
      );
    }

    Widget buildJoinTime(GroupMemberSchedule memberSchedule) {
      if (memberSchedule.lateness || memberSchedule.leaveEarly) {
        return Column(
          children: [
            if (memberSchedule.startAt != null)
              buildTimeView(memberSchedule.startAt!),
            buildDivision(),
            if (memberSchedule.endAt != null)
              buildTimeView(memberSchedule.endAt!),
          ],
        );
      }
      return const SizedBox.shrink();
    }

    return asyncMemberSchedule.when(
      data: (memberSchedule) {
        if (memberSchedule == null) {
          return const SizedBox.shrink();
        }
        return buildJoinTime(memberSchedule);
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
