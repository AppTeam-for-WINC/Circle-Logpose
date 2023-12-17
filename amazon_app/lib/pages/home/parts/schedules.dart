import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../popup/behind_and_early_setting/behind_and_early_setting.dart';
import '../../popup/schedule_detail_confirm/schedule_detail_confirm.dart';

class ScheduleCard extends ConsumerWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 375,
      height: 215,
      margin: const EdgeInsets.only(
        top: 20,
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
                                return const ScheduleDetailConfirm();
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
                        InkWell(
                          highlightColor: const Color(0xFFFBCEFF),
                          onTap: () {
                            debugPrint('aa');
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: const Center(
                              child: Column(
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
                        InkWell(
                          // highlightColor: const Color(0xFFFBCEFF),
                          highlightColor: Colors.pink,
                          onTap: () async {
                            await showCupertinoModalPopup<
                                BehindAndEarlySetting>(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: BehindAndEarlySetting(),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: const Center(
                              child: Column(
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
                        InkWell(
                          highlightColor: const Color(0xFFFBCEFF),
                          onTap: () async {
                            await showCupertinoModalPopup<
                                BehindAndEarlySetting>(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: BehindAndEarlySetting(),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: const Center(
                              child: Column(
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
                        InkWell(
                          highlightColor: const Color(0xFFFBCEFF),
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: const Center(
                              child: Column(
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
