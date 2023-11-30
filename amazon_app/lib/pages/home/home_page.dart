import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/popup/schedule_create_popup.dart';
import '../function/slide_segmented_tab_control.dart';
import '../group/create/group_create_page.dart';
import '../popup/schedule_detail_confirm.dart';
import '../group/setting/group_setting_page.dart';
import '../popup/behind_and_early_setting.dart';

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

class ScheduleCard extends ConsumerWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

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
                          '13:00-14:00',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return const ScheduleDetailConfirm();
                                });
                          },
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
                          onTap: () {
                            showCupertinoModalPopup(
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
                          onTap: () {
                            showCupertinoModalPopup(
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

class AttendanceRecord extends ConsumerWidget {
  const AttendanceRecord({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F3FE),
        child: const Padding(
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
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return const Center(
                          child: ScheduleCreatePopup(),
                        );
                      },
                    );
                  },
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
    );
  }
}

class GroupBox extends ConsumerWidget {
  const GroupBox({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GroupSettingPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.rocket),
            Text(
              "団体名",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Group extends ConsumerWidget {
  const Group({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F3FE),
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (int i = 0; i < 10; i++) const GroupBox(),
                  ],
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
                width: 250,
                height: 55,
                child: FloatingActionButton.extended(
                  backgroundColor: const Color(0xFF7B61FF),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GroupCreatePage()),
                    );
                  },
                  label: const Text(
                    '新しい団体を作成',
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
    );
  }
}
