import 'package:amazon_app/controller/common/color_exchanger.dart';
import 'package:amazon_app/controller/common/time_controller.dart';
import 'package:amazon_app/pages/src/home/parts/attendance/user_schedule_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../popup/behind_and_early_setting/behind_and_early_setting.dart';
import '../../../popup/schedule_detail_confirm/schedule_detail_confirm.dart';
import 'schedule_response.dart';

class GroupScheduleCard extends ConsumerStatefulWidget {
  const GroupScheduleCard({super.key, required this.groupData});
  final GroupProfileWithScheduleWithId groupData;
  @override
  ConsumerState<GroupScheduleCard> createState() {
    return _GroupScheduleCardState();
  }
}

class _GroupScheduleCardState extends ConsumerState<GroupScheduleCard> {
  // bool _isAttendance = false;
  // bool _isLeavingEarly = false;
  // bool _isBehindTime = false;
  // bool _isAbsence = false;

  @override
  Widget build(BuildContext context) {
    final groupProfileWithScheduleWithId = widget.groupData;
    final groupId = groupProfileWithScheduleWithId.groupId;
    final groupProfile = widget.groupData.groupProfile;
    final groupImage = widget.groupData.groupProfile.image;
    final groupSchedule = widget.groupData.groupSchedule;
    final groupScheduleId = widget.groupData.groupScheduleId;
    final userSchedule = ref.watch(setMemberScheduleProvider(groupScheduleId));
    final userScheduleNotifier =
        ref.watch(setMemberScheduleProvider(groupScheduleId).notifier);

    final isAttendance = userSchedule!.attendance!;
    final isLeavingEarly = userSchedule.leavingEarly!;
    final isBehindTime = userSchedule.lateness!;
    final isAbsence = userSchedule.absence!;

    return Container(
      width: 375,
      height: 215,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 19,
              ),
              height: 182,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 10,
                    ),
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await showCupertinoModalPopup<
                                  ScheduleDetailConfirm>(
                                context: context,
                                builder: (BuildContext context) {
                                  if (isAttendance) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.attendance,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.attendance,
                                      ),
                                      groupId: groupId,
                                      group: groupProfile,
                                      scheduleId: groupScheduleId,
                                      schedule: groupSchedule,
                                    );
                                  } else if (isLeavingEarly) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.leavingEarly,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.leavingEarly,
                                      ),
                                      groupId: groupId,
                                      group: groupProfile,
                                      scheduleId: groupScheduleId,
                                      schedule: groupSchedule,
                                    );
                                  } else if (isBehindTime) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.behindTime,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.behindTime,
                                      ),
                                      groupId: groupId,
                                      group: groupProfile,
                                      scheduleId: groupScheduleId,
                                      schedule: groupSchedule,
                                    );
                                  } else if (isAbsence) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.absence,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.absence,
                                      ),
                                      groupId: groupId,
                                      group: groupProfile,
                                      scheduleId: groupScheduleId,
                                      schedule: groupSchedule,
                                    );
                                  } else {
                                    return ScheduleDetailConfirm(
                                      responseIcon: null,
                                      responseText: null,
                                      groupId: groupId,
                                      group: groupProfile,
                                      scheduleId: groupScheduleId,
                                      schedule: groupSchedule,
                                    );
                                  }
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    groupSchedule.title,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Color(0xFF7B61FF),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      left: 25,
                    ),
                    child: Row(
                      children: [
                        // Attendance
                        GestureDetector(
                          onTap: () async {
                            userScheduleNotifier.setAttendance(
                              attendance: userSchedule.attendance!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: isAttendance,
                              leaveEarly: isLeavingEarly,
                              lateness: isBehindTime,
                              absence: isAbsence,
                              startAt: null,
                              endAt: null,
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: isAttendance
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ScheduleResponse.getIcon(
                                    ResponseType.attendance,
                                  ),
                                  ScheduleResponse.getText(
                                    ResponseType.attendance,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // LeavingEarly
                        GestureDetector(
                          onTap: () async {
                            userScheduleNotifier.setLeavingEarly(
                              leavingEarly: userSchedule.leavingEarly!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: isAttendance,
                              leaveEarly: isLeavingEarly,
                              lateness: isBehindTime,
                              absence: isAbsence,
                              startAt: null,
                              endAt: null,
                            );
                            if (!mounted) {
                              return;
                            }
                            if (isLeavingEarly) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BehindAndEarlySetting(
                                    groupProfileWithScheduleWithId:
                                        groupProfileWithScheduleWithId,
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.leavingEarly,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.leavingEarly,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: isLeavingEarly
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ScheduleResponse.getIcon(
                                    ResponseType.leavingEarly,
                                  ),
                                  ScheduleResponse.getText(
                                    ResponseType.leavingEarly,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // BehindTime (lateness)
                        GestureDetector(
                          onTap: () async {
                            userScheduleNotifier.setLateness(
                              lateness: userSchedule.lateness!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: isAttendance,
                              leaveEarly: isLeavingEarly,
                              lateness: isBehindTime,
                              absence: isAbsence,
                              startAt: null,
                              endAt: null,
                            );
                            if (!mounted) {
                              return;
                            }
                            if (isBehindTime) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BehindAndEarlySetting(
                                    groupProfileWithScheduleWithId:
                                        groupProfileWithScheduleWithId,
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.behindTime,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.behindTime,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: isBehindTime
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ScheduleResponse.getIcon(
                                    ResponseType.behindTime,
                                  ),
                                  ScheduleResponse.getText(
                                    ResponseType.behindTime,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Absence
                        GestureDetector(
                          onTap: () async {
                            userScheduleNotifier.setAbsence(
                              absence: userSchedule.absence!,
                            );

                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: isAttendance,
                              leaveEarly: isLeavingEarly,
                              lateness: isBehindTime,
                              absence: isAbsence,
                              startAt: null,
                              endAt: null,
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: isAbsence
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ScheduleResponse.getIcon(
                                    ResponseType.absence,
                                  ),
                                  ScheduleResponse.getText(
                                    ResponseType.absence,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 5,
            child: Container(
              width: 80,
              height: 38,
              decoration: BoxDecoration(
                color: hexToColor(groupSchedule.color),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                child: Text(
                  formatDateTimeExcYearHourMinuteDay(
                    groupSchedule.startAt,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 35,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: groupImage.startsWith('http')
                      ? NetworkImage(groupImage)
                      : AssetImage(groupImage) as ImageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
