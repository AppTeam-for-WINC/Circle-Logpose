import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../function/slide_segmented_tab_control.dart';
import 'parts/attendance.dart';
import 'parts/groups.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: TabBarView(
                    children: [
                      AttendanceRecord(),
                      Group(),
                    ],
                  ),
                ),
                //ここのRow切り出す
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        width: 375,
                        height: 77,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 3,
                                offset: Offset(0, 3),
                                color: Color.fromRGBO(0, 0, 0, 0.25)),
                          ],
                          border: Border.all(
                            color: const Color.fromRGBO(4, 49, 57, 0.05),
                          ),
                        ),
                        child: SegmentedTabControl(
                          radius: const Radius.circular(999),
                          backgroundColor: Colors.white,
                          tabTextColor: Colors.black,
                          selectedTabTextColor: Colors.white,
                          squeezeIntensity: 2,
                          height: 55,
                          tabs: [
                            SegmentTab(
                              textColor: const Color.fromRGBO(0, 0, 0, 1),
                              label: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 33,
                                    height: 33,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.20),
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'all',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.80),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '出席簿',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.expand_more,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              color: const Color(0xFF7B61FF),
                            ),
                            SegmentTab(
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.group,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: const Text(
                                      '団体',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedTextColor: Colors.white,
                              textColor: Colors.black,
                              color: const Color(0xFF7B61FF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}