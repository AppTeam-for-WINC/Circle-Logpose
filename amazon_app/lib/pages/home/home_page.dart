import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F3FE),
          child: DefaultTabController(
            length: 2,
            child: SafeArea(
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
                                  color: const Color(0xFF7B61FF)),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff76548C).withOpacity(0),
                const Color(0xff0F0439).withOpacity(0.3),
                const Color(0xff0F0439).withOpacity(0.4),
                const Color.fromARGB(255, 159, 146, 225).withOpacity(0.7),
              ],
              stops: const [0, 0.5, 0.8, 0.99],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: 15,
                child: SizedBox(
                  width: 180,
                  height: 55,
                  child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFF7B61FF),
                    onPressed: () {},
                    label: const Text(
                      '予定を作成',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
      height: 215,
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

List<Widget> scheduleList() {
  List<Widget> cards = [];

  for (int i = 0; i < 10; i++) {
    cards.add(const ScheduleCard());
  }

  return cards;
}
