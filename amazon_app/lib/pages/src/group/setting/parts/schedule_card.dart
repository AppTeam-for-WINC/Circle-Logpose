import 'package:amazon_app/controller/common/color_exchanger.dart';
import 'package:amazon_app/pages/src/group/setting/group_setting_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_setting/schedule_change.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/schedule_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.groupName,
  });

  final GroupScheduleAndId schedule;
  final String groupName;
  @override
  ConsumerState<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends ConsumerState<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.schedule.groupSchedule;
    final groupScheduleId = widget.schedule.groupScheduleId;
    final groupName = widget.groupName;

    return GestureDetector(
      onTap: () async {
        ref.watch(groupNameProvider.notifier).state = groupName;
        await showCupertinoModalPopup<ScheduleChange>(
          context: context,
          builder: (BuildContext context) {
            return ScheduleChange(
              groupScheduleId: groupScheduleId,
            );
          },
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: hexToColor(groupSchedule.color),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Center(
          child: Text(
            groupSchedule.title,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 69, 68, 68),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
