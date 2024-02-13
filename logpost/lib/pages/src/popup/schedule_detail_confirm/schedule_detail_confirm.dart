import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controller/common/color_exchanger.dart';
import '../../../../controller/common/time_controller.dart';
import '../../../../database/group/group/group.dart';
import '../../../../database/group/schedule/schedule/schedule.dart';
import 'parts/responsed_member.dart';

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
          left: 32,
          right: 32,
          bottom: deviceHeight * 0.02,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: CupertinoPopupSurface(
            child: SizedBox(
              width: deviceWidth * 0.9,
              height: deviceHeight * 0.55,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                  Container(
                    width: double.infinity,
                    height: deviceHeight * 0.11,
                    decoration: BoxDecoration(
                      color: hexToColor(groupSchedule.color),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 30,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: group.image.startsWith('http')
                              ? NetworkImage(group.image)
                              : AssetImage(group.image) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  if (responseIcon != null)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(top: 105, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: const Color(0xFFFBCEFF),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              responseIcon,
                              if (responseText != null) responseText,
                            ],
                          ),
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 120),
                          width: 220,
                          child: Text(
                            groupSchedule.title,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                formatDateTimeExcYearHourMinuteDay(
                                  groupSchedule.startAt,
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              formatDateTimeExcYearMonthDay(
                                groupSchedule.startAt,
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              '-',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              formatDateTimeExcYearMonthDay(
                                groupSchedule.endAt,
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        // Responsed members
                        ResponsedMembers(
                          groupProfile: group,
                          scheduleId: groupScheduleId,
                          schedule: groupSchedule,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.place,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    child: const Text(
                                      '場所',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.only(right: 30),
                                child: groupSchedule.place != null
                                    ? Text(
                                        groupSchedule.place!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_square,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    child: const Text(
                                      '詳細',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 100,
                                ), // 最大高さを設定
                                child: SingleChildScrollView(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(right: 30),
                                    child: groupSchedule.detail != null
                                        ? Text(
                                            groupSchedule.detail!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                            maxLines: 7,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
