import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../popup/schedule_create/schedule_create_popup.dart';
import 'schedules.dart';

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
                    //Databaseからスケジュールデータを一覧取得
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
                  onPressed: () async{
                    await showCupertinoModalPopup<ScheduleCreatePopup>(
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
