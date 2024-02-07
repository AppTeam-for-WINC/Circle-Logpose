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
  bool _isAttendance = false;
  bool _isLeavingEarly = false;
  bool _isBehindTime = false;
  bool _isAbsence = false;

  @override
  Widget build(BuildContext context) {
    final groupProfile = widget.groupData.groupProfile;
    final groupImage = widget.groupData.groupProfile.image;
    final groupSchedule = widget.groupData.groupSchedule;
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
                                  if (_isAttendance) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.attendance,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.attendance,
                                      ),
                                      group: groupProfile,
                                      schedule: groupSchedule,
                                    );
                                  } else if (_isLeavingEarly) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.leavingEarly,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.leavingEarly,
                                      ),
                                      group: groupProfile,
                                      schedule: groupSchedule,
                                    );
                                  } else if (_isBehindTime) {
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.behindTime,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.behindTime,
                                      ),
                                      group: groupProfile,
                                      schedule: groupSchedule,
                                    );
                                  } else if (_isAbsence){
                                    return ScheduleDetailConfirm(
                                      responseIcon: ScheduleResponse.getIcon(
                                        ResponseType.absence,
                                      ),
                                      responseText: ScheduleResponse.getText(
                                        ResponseType.absence,
                                      ),
                                      group: groupProfile,
                                      schedule: groupSchedule,
                                    );
                                  } else {
                                    return ScheduleDetailConfirm(
                                      responseIcon: null,
                                      responseText: null,
                                      group: groupProfile,
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAttendance = !_isAttendance;
                              _isLeavingEarly = false;
                              _isBehindTime = false;
                              _isAbsence = false;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: _isAttendance
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
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isAttendance = false;
                              _isLeavingEarly = !_isLeavingEarly;
                              _isBehindTime = false;
                              _isAbsence = false;
                            });
                            if (_isLeavingEarly) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BehindAndEarlySetting(
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
                              color: _isLeavingEarly
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
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isAttendance = false;
                              _isLeavingEarly = false;
                              _isBehindTime = !_isBehindTime;
                              _isAbsence = false;
                            });
                            if (_isBehindTime) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BehindAndEarlySetting(
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
                              color: _isBehindTime
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAttendance = false;
                              _isLeavingEarly = false;
                              _isBehindTime = false;
                              _isAbsence = !_isAbsence;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: _isAbsence
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
