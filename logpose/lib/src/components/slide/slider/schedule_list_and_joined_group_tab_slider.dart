import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../views/group/list/joined_group_list_page.dart';
import '../../../views/schedule/schedule_list_page.dart';
import '../src/slide_tab.dart';
import '../src/slide_tab_bar.dart';

class ScheduleListAndJoinedGroupTabSlider extends ConsumerStatefulWidget {
  const ScheduleListAndJoinedGroupTabSlider({super.key});

  @override
  ConsumerState createState() => _ScheduleListAndJoinedGroupTabSliderState();
}

class _ScheduleListAndJoinedGroupTabSliderState extends ConsumerState
<ScheduleListAndJoinedGroupTabSlider> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.zero,
              child: TabBarView(
                children: [
                  ScheduleListPage(),
                  JoinedGroupListPage(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: deviceHeight * 0.065,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: deviceWidth * 0.88,
                    height: deviceHeight * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2.5,
                          spreadRadius: 2.5,
                          offset: Offset(0, 3),
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
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
                          name: '出席簿',
                          textColor: const Color.fromRGBO(0, 0, 0, 1),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 33,
                                height: 33,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      0.20,
                                    ),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'all',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          0.80,
                                        ),
                                      ),
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
                          name: '団体',
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
    );
  }
}
