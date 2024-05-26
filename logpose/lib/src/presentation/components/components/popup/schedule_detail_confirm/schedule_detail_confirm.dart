import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/entity/group_profile.dart';
import '../../../../../domain/entity/group_schedule.dart';

import '../../../common/background.dart';
import '../../../common/custom_image/custom_image.dart';
import '../../../common/popup_header_color.dart';
import '../../../common/response_icon_and_text.dart';
import '../../../common/schedule_time_view.dart';
import '../../../common/schedule_title_view.dart';

import 'components/member/responsed_members.dart';
import 'components/schedule_detail_view.dart';
import 'components/schedule_place_view.dart';

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
                  const PopupBackground(),
                  PopupHeaderColor(color: groupSchedule.color),
                  Positioned(
                    top: 70,
                    left: 30,
                    child: CustomImage(
                      imagePath: group.image,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: ResponseIconAndText(
                      responseIcon: responseIcon,
                      responseText: responseText,
                      width: deviceWidth * 0.2,
                      height: deviceHeight * 0.093,
                      marginTop: 105,
                      marginLeft: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleTitleView(
                          title: groupSchedule.title,
                          width: deviceWidth * 0.5,
                          marginTop: 120,
                          fontSize: 26,
                        ),
                        ScheduleTimeView(groupSchedule: groupSchedule),
                        ResponsedMembers(
                          groupProfile: group,
                          scheduleId: groupScheduleId,
                          groupSchedule: groupSchedule,
                        ),
                        SchedulePlaceView(place: groupSchedule.place),
                        ScheduleDetailView(detail: groupSchedule.detail),
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
