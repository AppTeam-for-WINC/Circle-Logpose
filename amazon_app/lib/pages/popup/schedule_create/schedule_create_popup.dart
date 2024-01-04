import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/schedule/schedule/schedule_controller.dart';
import '../schedule_create/schedule_create_controller.dart';
import '/pages/home/home_page.dart';
import 'parts/group_picker.dart';

//schedule.groupNames! など、無理やりnullじゃないことを指定しているが、
//いちいちめんどくさいので、schedule_create_controller.dartファイルでnull checkを後で行おう!

//showTesmPicker()メソッドは、別ファイルに記述する。

//onPressed(): 内のコードを別ファイルに記述する。

//スケジュールのカラー設定なくね？

//スケジュールの日付、時刻設定なくね？

class ScheduleCreatePopup extends ConsumerStatefulWidget {
  const ScheduleCreatePopup({super.key});

  @override
  ConsumerState createState() => ScheduleCreatePopupState();
}

class ScheduleCreatePopupState extends ConsumerState<ScheduleCreatePopup> {

  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(scheduleCreationDataProvider);

    return CupertinoPopupSurface(
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
            CupertinoButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF7B61FF),
              ),
            ),
            // カラー選択↓
            const Positioned(
              top: 50,
              left: 30,
              child: Icon(
                Icons.color_lens,
                size: 50,
                color: Colors.grey,
              ),
            ),
            // カラー選択↑

            // タイトル追加↓
            //ここのContainer切り出す
            Container(
              margin: const EdgeInsets.only(top: 110, left: 40),
              width: 270, // 横幅を指定
              child: CupertinoTextField(
                placeholder: 'タイトルを追加',
                controller: schedule.titleController,
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
              margin: const EdgeInsets.only(
                left: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 団体選択↓
                  //ここのContainer切り出す
                  Container(
                    margin: const EdgeInsets.only(top: 160),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.expand_more,
                          color: Colors.grey,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            showTeamPicker(
                              context,
                              schedule,
                              (int index) {
                                setState(() {
                                  schedule
                                    ..selectedGroupId = schedule.groupIds![index]
                                    ..selectedGroupName =
                                        schedule.groupNames![index];
                                });
                              },
                            );
                          },
                          child: Text(
                            schedule.selectedGroupName!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF7B61FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 団体選択↑

                  // 活動日時↓
                  //ここのContainer切り出す
                  Container(
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 25,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: const Text(
                            '2023/10/19   13:00-14:00',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 活動日時↑

                  // 場所↓
                  //ここのContainer切り出す
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
                          width: 100,
                          child: CupertinoTextField(
                            placeholder: '場所を追加',
                            controller: schedule.placeController,
                            // controller: placeController,
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
                              width: 100,
                              child: CupertinoTextField(
                                controller: schedule.detailController,
                                // controller: detailController,
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
                      onPressed: () async {
                        final title = schedule.titleController.text;
                        final place = schedule.placeController.text;
                        final detail = schedule.detailController.text;
                        await ScheduleController.create(
                          groupId: schedule.selectedGroupId!,
                          title: title,
                          color: schedule.selectedColor,
                          startAt: schedule.selectedDate,
                          endAt: schedule.selectedDate.add(
                            const Duration(
                              hours: 3,
                            ),
                          ),
                          place: place,
                          detail: detail,
                        );
                      },
                    ),
                  ),
                  //作成ボタン↑
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
