import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MaterialApp(
        home: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F3FE),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
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
                            ),
                            child: SegmentedTabControl(
                              // Customization of widget
                              radius: const Radius.circular(999),
                              backgroundColor: Colors.white,
                              // indicatorColor: Colors.orange.shade200,
                              tabTextColor: Colors.black,
                              selectedTabTextColor: Colors.white,
                              squeezeIntensity: 2,
                              height: 55,
                              // tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                              // textStyle: Theme.of(context).textTheme.bodyLarge,
                              // Options for selection
                              // All specified values will override the [SegmentedTabControl] setting
                              tabs: [
                                SegmentTab(
                                  textColor: Colors.black,
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
                                          borderRadius:
                                              BorderRadius.circular(33),
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
                                      )
                                    ],
                                  ),
                                  // For example, this overrides [indicatorColor] from [SegmentedTabControl]
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
                                  // backgroundColor: Color(0xFF7B61FF),
                                  selectedTextColor: Colors.white,
                                  textColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Sample pages
                    const Padding(
                      padding: EdgeInsets.only(top: 130),
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                ScheduleCard(),
                                ScheduleCard(),
                                ScheduleCard(),
                                ScheduleCard(),
                                ScheduleCard(),
                                ScheduleCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 201,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 19,
            ),
            height: 182,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
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
                        '13:00-14:00',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const SizedBox(
                          width: 117,
                          child: Row(
                            children: [
                              Text(
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
          Positioned(
            left: 10,
            child: Container(
              width: 80,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFD8EB61),
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Center(
                child: Text(
                  '9/20',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const Positioned(
            top: -5,
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
