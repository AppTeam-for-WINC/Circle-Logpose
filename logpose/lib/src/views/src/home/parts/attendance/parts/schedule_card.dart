import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../controllers/providers/group/group_member_schedule_provider.dart';

import '../../../../../../models/group/group_profile_with_schedule_with_id_model.dart';

import '../../../../../../services/database/group_member_schedule_setting.dart';

import '../../../../../../utils/color/color_exchanger.dart';
import '../../../../../../utils/schedule/schedule_response.dart';
import '../../../../../../utils/time/time_utils.dart';

import '../../../../popup/behind_and_early_setting/behind_and_early_setting.dart';
import '../../../../popup/schedule_detail_confirm/schedule_detail_confirm.dart';

class GroupScheduleCard extends ConsumerStatefulWidget {
  const GroupScheduleCard({super.key, required this.groupData});
  final GroupProfileWithScheduleWithId groupData;
  @override
  ConsumerState<GroupScheduleCard> createState() {
    return _GroupScheduleCardState();
  }
}

class _GroupScheduleCardState extends ConsumerState<GroupScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupProfileWithScheduleWithId = widget.groupData;
    final groupProfile = widget.groupData.groupProfile;
    final groupImage = widget.groupData.groupProfile.image;
    final groupSchedule = widget.groupData.groupSchedule;
    final groupScheduleId = widget.groupData.groupScheduleId;

    final userSchedule =
        ref.watch(groupMemberScheduleProvider(groupScheduleId));
    final userScheduleNotifier =
        ref.watch(groupMemberScheduleProvider(groupScheduleId).notifier);

    final isAttendance = userSchedule?.attendance ?? false;
    final isLeavingEarly = userSchedule?.leavingEarly ?? false;
    final isBehindTime = userSchedule?.lateness ?? false;
    final isAbsence = userSchedule?.absence ?? false;

    return Container(
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.215,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 19,
              ),
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
                                fontSize: 17,
                              ),
                            ),
                            const Text(
                              '-',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              formatDateTimeExcYearMonthDay(
                                groupSchedule.endAt,
                              ),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showCupertinoModalPopup<
                                ScheduleDetailConfirm>(
                              context: context,
                              builder: (BuildContext context) {
                                if (ref
                                    .read(
                                      groupMemberScheduleProvider(
                                        groupScheduleId,
                                      ),
                                    )!
                                    .attendance!) {
                                  return ScheduleDetailConfirm(
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.attendance,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.attendance,
                                    ),
                                    group: groupProfile,
                                    scheduleId: groupScheduleId,
                                    schedule: groupSchedule,
                                  );
                                } else if (ref
                                    .read(
                                      groupMemberScheduleProvider(
                                        groupScheduleId,
                                      ),
                                    )!
                                    .leavingEarly!) {
                                  return ScheduleDetailConfirm(
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.leavingEarly,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.leavingEarly,
                                    ),
                                    group: groupProfile,
                                    scheduleId: groupScheduleId,
                                    schedule: groupSchedule,
                                  );
                                } else if (ref
                                    .read(
                                      groupMemberScheduleProvider(
                                        groupScheduleId,
                                      ),
                                    )!
                                    .lateness!) {
                                  return ScheduleDetailConfirm(
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.behindTime,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.behindTime,
                                    ),
                                    group: groupProfile,
                                    scheduleId: groupScheduleId,
                                    schedule: groupSchedule,
                                  );
                                } else if (ref
                                    .read(
                                      groupMemberScheduleProvider(
                                        groupScheduleId,
                                      ),
                                    )!
                                    .absence!) {
                                  return ScheduleDetailConfirm(
                                    responseIcon: ScheduleResponse.getIcon(
                                      ResponseType.absence,
                                    ),
                                    responseText: ScheduleResponse.getText(
                                      ResponseType.absence,
                                    ),
                                    group: groupProfile,
                                    scheduleId: groupScheduleId,
                                    schedule: groupSchedule,
                                  );
                                } else {
                                  return ScheduleDetailConfirm(
                                    responseIcon: null,
                                    responseText: null,
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
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: deviceWidth * 0.35,
                                ),
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
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Attendance
                        GestureDetector(
                          onTap: () async {
                            userScheduleNotifier.setAttendance(
                              attendance: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .attendance!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .attendance,
                              leaveEarly: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .leavingEarly,
                              lateness: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .lateness,
                              absence: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .absence,
                            );
                          },
                          child: Container(
                            width: deviceWidth * 0.185,
                            height: deviceHeight * 0.085,
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
                              leavingEarly: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .leavingEarly!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .attendance,
                              leaveEarly: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .leavingEarly,
                              lateness: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .lateness,
                              absence: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .absence,
                            );
                            if (!mounted) {
                              return;
                            }
                            if (ref
                                .read(
                                  groupMemberScheduleProvider(
                                    groupScheduleId,
                                  ),
                                )!
                                .leavingEarly!) {
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
                            width: deviceWidth * 0.185,
                            height: deviceHeight * 0.085,
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
                              lateness: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .lateness!,
                            );
                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .attendance,
                              leaveEarly: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .leavingEarly,
                              lateness: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .lateness,
                              absence: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .absence,
                            );
                            if (!mounted) {
                              return;
                            }
                            if (ref
                                .read(
                                  groupMemberScheduleProvider(groupScheduleId),
                                )!
                                .lateness!) {
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
                            width: deviceWidth * 0.185,
                            height: deviceHeight * 0.085,
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
                              absence: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .absence!,
                            );

                            await GroupMemberScheduleSetting.update(
                              scheduleId: groupScheduleId,
                              attendance: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .attendance,
                              leaveEarly: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .leavingEarly,
                              lateness: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .lateness,
                              absence: ref
                                  .read(
                                    groupMemberScheduleProvider(
                                      groupScheduleId,
                                    ),
                                  )!
                                  .absence,
                            );
                          },
                          child: Container(
                            width: deviceWidth * 0.185,
                            height: deviceHeight * 0.085,
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