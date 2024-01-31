import 'package:amazon_app/pages/group/create/parts/contents/group_contents.dart';
import 'package:amazon_app/pages/home/parts/group/joined_groups.dart';
import 'package:amazon_app/pages/slide/src/slide_tab.dart';
import 'package:amazon_app/pages/slide/src/slide_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupCreatePage extends ConsumerWidget {
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  GroupContents(),
                  GroupPage(),
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
                          color: Color.fromRGBO(0, 0, 0, 0.25),
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
