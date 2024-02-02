import 'package:amazon_app/pages/src/popup/schedule_detail_confirm/parts/present_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'behind_and_early_setting_controller.dart';

class BehindAndEarlySetting extends ConsumerStatefulWidget {
  const BehindAndEarlySetting({super.key});

  @override
  ConsumerState<BehindAndEarlySetting> createState() {
    return _BehindAndEarlySettingState();
  }
}

class _BehindAndEarlySettingState
    extends ConsumerState<BehindAndEarlySetting> {
  bool _isPinkAttendance = false;
  bool _isPinkLeavingEarly = false;
  bool _isPinkBehindTime = false;
  bool _isPinkAbsence = false;
  @override
  //絶対書く
  Widget build(BuildContext context) {
    final productList = ProductList().productList;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: SizedBox(
          width: 360,
          height: 500,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(color: Colors.white), //メインの白
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration:
                    const BoxDecoration(color: Color(0xFFD8EB61)), //上の黄緑
              ),
              Positioned(
                top: 60,
                left: 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/group_img.jpeg'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 120),
                      child: const Text(
                        'Designner23',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: const Text('2023/9/20 13:00-14:00'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.group,
                            size: 25,
                            color: Colors.grey,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text(
                              '参加メンバー |',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const PresentMember(),
                        ],
                      ),
                    ),
                    //ここのContainer切り出す
                    Container(
                      margin: const EdgeInsets.only(top: 70, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 77,
                            height: 77,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint('pressed');
                                setState(() {
                                  _isPinkAttendance = !_isPinkAttendance;
                                  _isPinkLeavingEarly = false;
                                  _isPinkBehindTime = false;
                                  _isPinkAbsence = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: _isPinkAttendance
                                    ? const Color(0xFFFBCEFF)
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    productList[0],
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    '出席',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 77,
                            height: 77,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint('pressed2');
                                setState(() {
                                  _isPinkAttendance = false;
                                  _isPinkLeavingEarly = !_isPinkLeavingEarly;
                                  _isPinkBehindTime = false;
                                  _isPinkAbsence = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: _isPinkLeavingEarly
                                    ? const Color(0xFFFBCEFF)
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    productList[1],
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    '早退',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 77,
                            height: 77,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint('pressed3');
                                setState(() {
                                  _isPinkAttendance = false;
                                  _isPinkLeavingEarly = false;
                                  _isPinkBehindTime = !_isPinkBehindTime;
                                  _isPinkAbsence = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: _isPinkBehindTime
                                    ? const Color(0xFFFBCEFF)
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    productList[2],
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    '遅刻',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 77,
                            height: 77,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint('pressed3');
                                setState(() {
                                  _isPinkAttendance = false;
                                  _isPinkLeavingEarly = false;
                                  _isPinkBehindTime = false;
                                  _isPinkAbsence = !_isPinkAbsence;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: _isPinkAbsence
                                    ? const Color(0xFFFBCEFF)
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    productList[3],
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    '欠席',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Icon(Icons.schedule),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 80, top: 20),
                          child: const Text(
                            '参加時間',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30, top: 20),
                          child: const Text(
                            '13:30-14:00',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
