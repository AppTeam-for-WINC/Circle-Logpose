import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../common/popup_header_color.dart';

import '../../../common/response_icon_and_text.dart';
import '../../../common/schedule_time_view.dart';
import '../components/schedule_title.dart';
import 'components/join_time.dart';

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
              PopupHeaderColor(color: groupSchedule.color),
              ResponseIconAndText(
                responseIcon: responseIcon,
                responseText: responseText,
                width: 80,
                height: 80,
                marginTop: 100,
                marginLeft: 260,
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
