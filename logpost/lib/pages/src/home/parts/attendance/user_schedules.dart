import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../popup/schedule_create/schedule_create.dart';
import 'schedule_box.dart';
import 'user_schedule_controller.dart';

class ScheduleManagement extends ConsumerStatefulWidget {
  const ScheduleManagement({super.key});
  @override
  ConsumerState createState() => _ScheduleManagementState();
}

class _ScheduleManagementState extends ConsumerState<ScheduleManagement> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupExist = ref.watch(checkGroupExistProvider);
    final asyncGroupsDataList = ref.watch(watchUserScheduleProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF5F3FE),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: deviceHeight * 0.14,
            child: Container(
              width: deviceWidth * 0.9,
              height: deviceHeight,
              color: const Color(0xFFF5F3FE),
              child: SingleChildScrollView(
                // 後ほど、ListView.builder を用いると良い。
                child: Column(
                  children: [
                    asyncGroupsDataList.when(
                      data: (groupDataList) {
                        if (groupDataList.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            ...groupDataList.map((groupData) {
                              return GroupScheduleCard(groupData: groupData);
                            }),
                            const SizedBox(
                              height: 200,
                            ),
                          ],
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (error, stack) => Text('$error'),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0, // 画面の底部に配置
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 0.12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff76548C).withOpacity(0),
                    const Color.fromARGB(255, 26, 7, 100).withOpacity(0.3),
                    const Color.fromARGB(255, 22, 0, 109).withOpacity(0.4),
                    const Color.fromARGB(255, 159, 146, 225).withOpacity(0.7),
                  ],
                  stops: const [0, 0.5, 0.8, 0.99],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          if (groupExist is AsyncLoading)
            const Center(child: CupertinoActivityIndicator()),
          if (groupExist is AsyncError)
            Center(child: Text('Error: ${groupExist.error}')),

          // グループが存在する場合のみボタンを表示
          if (groupExist is AsyncData && groupExist.value == true)
            Positioned(
              top: deviceHeight * 0.875,
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: const Color.fromARGB(255, 107, 88, 252),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(225, 127, 145, 145),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  onPressed: () async {
                    await showCupertinoModalPopup<ScheduleCreate>(
                      context: context,
                      builder: (BuildContext context) {
                        return const ScheduleCreate();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        '予定を作成',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}