import 'package:amazon_app/controller/common/color_controller.dart';
import 'package:amazon_app/pages/common/src/color/color_palette.dart';
import 'package:amazon_app/pages/src/home/parts/group/controller/joined_group_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/activity_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'parts/group_picker/button.dart';
import 'schedule_create_controller.dart';

//スケジュールの日付、時刻設定なくね？

class ScheduleCreate extends ConsumerStatefulWidget {
  const ScheduleCreate({super.key});

  @override
  ConsumerState createState() => _ScheduleCreateState();
}

class _ScheduleCreateState extends ConsumerState<ScheduleCreate> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(createGroupScheduleProvider);
    final selectedColor = ref.watch(scheduleColorProvider);
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
    final groupsProfile = ref.watch(readJoinedGroupsProfileProvider);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: SizedBox(
          width: 360,
          height: 500,
          child: Stack(
            children: [
              // ポップアップ下部の白色↓
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              // ポップアップ下部の白色↑
              Positioned(
                top: 10,
                left: 10,
                child: CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF7B61FF),
                  ),
                ),
              ),
              // カラー選択↓
              Positioned(
                top: 40,
                left: 20,
                child: CupertinoButton(
                  onPressed: () {
                    showCupertinoDialog<Widget>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          content: SizedBox(
                            height: 110, // Set a fixed height for the GridView
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 18,
                              ),
                              itemCount: scheduleColorPalette.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Update the state with the selected color
                                    ref
                                        .watch(scheduleColorProvider.notifier)
                                        .color = scheduleColorPalette[index];
                                    Navigator.of(context).pop();
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: scheduleColorPalette[index],
                                      border: selectedColor ==
                                              scheduleColorPalette[index]
                                          ? Border.all(width: 2)
                                          : null,
                                    ),
                                    child: selectedColor ==
                                            scheduleColorPalette[index]
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.circle,
                    size: 50,
                    color: selectedColor,
                  ),
                ),
              ),
              // カラー選択↑
    
              // タイトル追加↓
              Container(
                margin: const EdgeInsets.only(top: 110, left: 40),
                width: 270, // 横幅を指定
                child: CupertinoTextField(
                  placeholder: 'タイトルを追加',
                  controller: scheduleNotifier.titleController,
                  placeholderStyle: const TextStyle(color: Colors.grey),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              // タイトル追加↑

              Container(
                margin: const EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Select group
                    GroupPickerButton(groupsProfile: groupsProfile),
                    // Activity time
                    const ScheduleActivityTime(),
    
                    // 場所↓
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.place,
                            size: 25,
                            color: Colors.grey,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 270,
                            child: CupertinoTextField(
                              controller: scheduleNotifier.placeController,
                              placeholder: '場所を追加',
                              placeholderStyle:
                                  const TextStyle(color: Colors.grey),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 場所↑
    
                    // 詳細のコンテナ↓
                    //ここのContainer切り出す
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // 詳細左部のアイコン↓
                              const Icon(
                                Icons.edit_square,
                                size: 25,
                                color: Colors.grey,
                              ),
                              // 詳細左部のアイコン↑
                              // 詳細テキスト↓
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 270,
                                child: CupertinoTextField(
                                  controller: scheduleNotifier.detailController,
                                  placeholder: '詳細を追加',
                                  placeholderStyle:
                                      const TextStyle(color: Colors.grey),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // 詳細テキスト↑
                            ],
                          ),
                          // 詳細内容↑
                        ],
                      ),
                    ),
                    // 詳細のコンテナ↑
                    //作成ボタン↓
                    Container(
                      width: 100,
                      height: 50,
                      margin: const EdgeInsets.only(
                        right: 90,
                        left: 90,
                        top: 60,
                        bottom: 10,
                      ),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF7B61FF),
                      ),
                      child: CupertinoButton(
                        child: const Text(
                          'create',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ),
                    //作成ボタン↑
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
