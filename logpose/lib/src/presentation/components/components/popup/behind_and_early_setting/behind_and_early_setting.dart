import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../components/header/header.dart';
import '../components/schedule_time_view/schedule_time_view.dart';
import 'components/join_time/join_time.dart';
import 'components/response_icon_and_text/response_icon_and_text.dart';
import 'components/title/schedule_title.dart';

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
              Header(color: groupSchedule.color),
              ResponseIconAndText(
                responseIcon: responseIcon,
                responseText: responseText,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScheduleTitle(title: groupSchedule.title),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ScheduleTimeView(groupSchedule: groupSchedule),
                    ),
                  ],
                ),
              ),
              JoinTime(groupData: groupData),
            ],
          ),
        ),
      ),
    );
  }
}
