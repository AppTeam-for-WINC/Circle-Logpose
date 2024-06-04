import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/schedule_response.dart';

import '../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../common/popup_header_color.dart';
import '../../../common/response_icon_and_text.dart';
import '../../../common/schedule_time_view.dart';
import '../../../common/schedule_title_view.dart';

import 'components/join_time.dart';

class BehindAndEarlySetting extends ConsumerStatefulWidget {
  const BehindAndEarlySetting({
    super.key,
    required this.groupProfileAndScheduleAndId,
    required this.responseType,
  });

  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;
  final ResponseType responseType;

  @override
  ConsumerState<BehindAndEarlySetting> createState() {
    return _BehindAndEarlySettingState();
  }
}

class _BehindAndEarlySettingState extends ConsumerState<BehindAndEarlySetting> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupData = widget.groupProfileAndScheduleAndId;
    final groupSchedule = widget.groupProfileAndScheduleAndId.groupSchedule;
    final responseType = widget.responseType;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          width: deviceWidth * 0.88,
          height: deviceHeight * 0.33,
          decoration: const BoxDecoration(color: CupertinoColors.white),
          child: Stack(
            children: [
              PopupHeaderColor(color: groupSchedule.color),
              ResponseIconAndText(responseType: responseType),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScheduleTitleView(title: groupSchedule.title),
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
