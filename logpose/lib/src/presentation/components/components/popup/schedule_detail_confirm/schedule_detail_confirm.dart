import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/group_profile.dart';
import '../../../../../domain/entity/group_schedule.dart';


import '../components/background/background.dart';
import '../components/header/header.dart';
import '../components/schedule_time_view/schedule_time_view.dart';

import 'components/detail/detail.dart';
import 'components/group_image/group_image.dart';
import 'components/member/responsed_members.dart';
import 'components/place/place.dart';
import 'components/response_icon_and_text.dart/response_icon_and_text.dart';
import 'components/title/schedule_title.dart';

class ScheduleDetailConfirm extends ConsumerStatefulWidget {
  const ScheduleDetailConfirm({
    super.key,
    required this.responseIcon,
    required this.responseText,
    required this.group,
    required this.scheduleId,
    required this.schedule,
  });
  final Icon? responseIcon;
  final Text? responseText;
  final GroupProfile group;
  final String scheduleId;
  final GroupSchedule schedule;

  @override
  ConsumerState createState() => _ScheduleDetailConfirmState();
}

class _ScheduleDetailConfirmState extends ConsumerState<ScheduleDetailConfirm> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final responseIcon = widget.responseIcon;
    final responseText = widget.responseText;
    final group = widget.group;
    final groupSchedule = widget.schedule;
    final groupScheduleId = widget.scheduleId;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: deviceWidth * 0.06,
          right: deviceWidth * 0.06,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: CupertinoPopupSurface(
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight * 0.55,
              child: Stack(
                children: [
                  const Background(),
                  Header(color: groupSchedule.color),
                  GroupImage(imagePath: group.image),
                  ResponseIconAndText(
                    responseIcon: responseIcon,
                    responseText: responseText,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleTitle(title: groupSchedule.title),
                        ScheduleTimeView(groupSchedule: groupSchedule),
                        ResponsedMembers(
                          groupProfile: group,
                          scheduleId: groupScheduleId,
                          groupSchedule: groupSchedule,
                        ),
                        Place(place: groupSchedule.place),
                        Detail(detail: groupSchedule.detail),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
