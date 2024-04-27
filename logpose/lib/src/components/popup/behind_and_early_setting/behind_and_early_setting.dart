import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import 'components/activity_time/activity_time.dart';
import 'components/header/header.dart';
import 'components/join_time/join_time.dart';
import 'components/response_icon_and_text/response_icon_and_text.dart';

class BehindAndEarlySetting extends ConsumerStatefulWidget {
  const BehindAndEarlySetting({
    super.key,
    required this.groupProfileAndScheduleAndId,
    required this.responseIcon,
    required this.responseText,
  });

  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;
  final Icon responseIcon;
  final Text responseText;
  @override
  ConsumerState<BehindAndEarlySetting> createState() {
    return _BehindAndEarlySettingState();
  }
}

class _BehindAndEarlySettingState extends ConsumerState<BehindAndEarlySetting> {
  @override
  Widget build(BuildContext context) {
    final groupData = widget.groupProfileAndScheduleAndId;
    final groupSchedule = widget.groupProfileAndScheduleAndId.groupSchedule;
    final responseIcon = widget.responseIcon;
    final responseText = widget.responseText;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          width: 360,
          height: 340,
          decoration: const BoxDecoration(color: CupertinoColors.white),
          child: Stack(
            children: [
              Header(colorToString: groupSchedule.color),
              ResponseIconAndText(
                responseIcon: responseIcon,
                responseText: responseText,
              ),
              ActivityTime(
                title: groupSchedule.title,
                startAt: groupSchedule.startAt,
                endAt: groupSchedule.endAt,
                groupData: groupData,
              ),
              JoinTime(groupData: groupData),
            ],
          ),
        ),
      ),
    );
  }
}
