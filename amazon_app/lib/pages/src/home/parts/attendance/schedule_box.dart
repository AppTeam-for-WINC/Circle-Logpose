import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../popup/behind_and_early_setting/behind_and_early_setting.dart';
import '../../../popup/schedule_detail_confirm/schedule_detail_confirm.dart';

class GroupScheduleCard extends ConsumerStatefulWidget {
  const GroupScheduleCard({super.key});

  @override
  ConsumerState<GroupScheduleCard> createState() {
    return _GroupScheduleCardState();
  }
}

class _GroupScheduleCardState extends ConsumerState<GroupScheduleCard> {
  bool _isPinkAttendance = false;
  bool _isPinkLeavingEarly = false;
  bool _isPinkBehindTime = false;
  bool _isPinkAbsence = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 215,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Stack(
        children: [
          //ここのCenter切り出す
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
                        const Text(
                          //Databaseから取得
                          '13:00-14:00',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showCupertinoModalPopup<
                                ScheduleDetailConfirm>(
                              context: context,
                              builder: (BuildContext context) {
                                if (_isPinkAttendance) {
                                  return const ScheduleDetailConfirm(
                                    responseIcon: '_isPinkAttendance',
                                  );
                                } else if (_isPinkLeavingEarly) {
                                  return const ScheduleDetailConfirm(
                                    responseIcon: '_isPinkLeavingEarly',
                                  );
                                } else if (_isPinkBehindTime) {
                                  return const ScheduleDetailConfirm(
                                    responseIcon: '_isPinkBehindTime',
                                  );
                                } else {
                                  return const ScheduleDetailConfirm(
                                    responseIcon: '_isPinkAbsence',
                                  );
                                }
                              },
                            );
                          },
                          child: const SizedBox(
                            width: 117,
                            child: Row(
                              children: [
                                Text(
                                  //Databaseから取得
                                  'Designer23',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
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
                              _isPinkAttendance = !_isPinkAttendance;
                              _isPinkLeavingEarly = false;
                              _isPinkBehindTime = false;
                              _isPinkAbsence = false;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: _isPinkAttendance
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    //Databaseから取得
                                    '出席',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isPinkAttendance = false;
                              _isPinkLeavingEarly = !_isPinkLeavingEarly;
                              _isPinkBehindTime = false;
                              _isPinkAbsence = false;
                            });
                            if (_isPinkLeavingEarly) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const BehindAndEarlySetting(
                                    responseIcon: '_isPinkLeavingEarly',
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
                              color: _isPinkLeavingEarly
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    //Databaseから取得
                                    '早退',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isPinkAttendance = false;
                              _isPinkLeavingEarly = false;
                              _isPinkBehindTime = !_isPinkBehindTime;
                              _isPinkAbsence = false;
                            });
                            if (_isPinkBehindTime) {
                              await showCupertinoModalPopup<
                                  BehindAndEarlySetting>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const BehindAndEarlySetting(
                                    responseIcon: '_isPinkBehindTime',
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
                              color: _isPinkBehindTime
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    //Databaseから取得
                                    '遅刻',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPinkAttendance = false;
                              _isPinkLeavingEarly = false;
                              _isPinkBehindTime = false;
                              _isPinkAbsence = !_isPinkAbsence;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: _isPinkAbsence
                                  ? const Color(0xFFFBCEFF)
                                  : Colors.white,
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    //Databaseから取得
                                    '欠席',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
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
                color: const Color(0xFFD8EB61),
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Center(
                child: Text(
                  //Databaseから取得
                  '9/20',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const Positioned(
            right: 35,
            child: Icon(
              Icons.group,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
