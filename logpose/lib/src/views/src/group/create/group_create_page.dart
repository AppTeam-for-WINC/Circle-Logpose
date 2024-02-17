import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/slide/src/slide_tab.dart';
import '../../../widgets/slide/src/slide_tab_bar.dart';
import '../../home/parts/group/joined_groups.dart';
import 'parts/components/group_contents.dart';

class GroupCreatePage extends ConsumerWidget {
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  GroupCreateContents(),
                  JoinedGroupPage(),
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
                        const SegmentTab(
                          name: '団体作成',
                          textColor: Color.fromRGBO(0, 0, 0, 1),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  '団体作成',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.expand_more,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          color: Color(0xFF7B61FF),
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
