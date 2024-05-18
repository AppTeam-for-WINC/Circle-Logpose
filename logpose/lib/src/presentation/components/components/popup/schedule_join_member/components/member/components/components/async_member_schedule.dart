import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../domain/providers/group/schedule/watch_responesd_group_member_schedule_provider.dart';
import '../../../../../../../../../utils/time/time_utils.dart';

class AsyncMemberSchedule extends ConsumerStatefulWidget {
  const AsyncMemberSchedule({
    super.key,
    required this.scheduleId,
    required this.accountId,
  });
  final String scheduleId;
  final String accountId;

  @override
  ConsumerState<AsyncMemberSchedule> createState() =>
      _AsyncMemberScheduleState();
}

class _AsyncMemberScheduleState extends ConsumerState<AsyncMemberSchedule> {
  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  @override
  Widget build(BuildContext context) {
    final asyncMemberSchedule = ref.watch(
      watchResponsedGroupMemberScheduleProvider(
        (scheduleId: widget.scheduleId, accountId: widget.accountId),
      ),
    );

    return asyncMemberSchedule.when(
      data: (memberSchedule) {
        if (memberSchedule == null) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            if (memberSchedule.lateness || memberSchedule.leaveEarly)
              Column(
                children: [
                  if (memberSchedule.startAt != null)
                    Text(
                      _formatDateTimeExcYear(memberSchedule.startAt!),
                      style: const TextStyle(fontSize: 12),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Text(
                      '|',
                      style: TextStyle(
                        fontSize: 9,
                      ),
                    ),
                  ),
                  if (memberSchedule.endAt != null)
                    Text(
                      _formatDateTimeExcYear(memberSchedule.endAt!),
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
