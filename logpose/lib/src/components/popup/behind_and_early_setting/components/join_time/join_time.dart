import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import 'components/end_picker_button.dart';
import 'components/start_picker_button.dart';

class JoinTime extends ConsumerStatefulWidget {
  const JoinTime({
    super.key,
    required this.groupData,
  });
  final GroupProfileAndScheduleAndId groupData;

  @override
  ConsumerState createState() => _JoinTimeState();
}

class _JoinTimeState extends ConsumerState<JoinTime> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.groupData.groupSchedule;
    final groupScheduleId = widget.groupData.groupScheduleId;

    return Container(
      padding: const EdgeInsets.only(top: 200),
      margin: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(CupertinoIcons.calendar),
              Text(
                '参加時間',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              StartPickerButton(
                groupSchedule: groupSchedule,
                groupScheduleId: groupScheduleId,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 2,
                ),
                child: Text(
                  '~',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              EndPickerButton(
                groupSchedule: groupSchedule,
                groupScheduleId: groupScheduleId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
