import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/src/color/color_palette.dart';
import '../../home/parts/group/controller/joined_group_controller.dart';
import 'parts/activity_time.dart';
import 'parts/group_picker/button.dart';
import 'schedule_create_controller.dart';

class ScheduleCreate extends ConsumerStatefulWidget {
  const ScheduleCreate({super.key});

  @override
  ConsumerState createState() => _ScheduleCreateState();
}

class _ScheduleCreateState extends ConsumerState<ScheduleCreate> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);
    final schedule = ref.watch(createGroupScheduleProvider);
    final scheduleNotifier = ref.watch(createGroupScheduleProvider.notifier);
    final groupsProfile = ref.watch(readJoinedGroupsProfileProvider);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          color: Colors.white,
          width: deviceWidth * 0.88,
          height: deviceHeight * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.only(left: 15, top: 15),
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF7B61FF),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.only(left: 20),
                onPressed: () {
                  showCupertinoDialog<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        content: SizedBox(
                          height: 110,
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
                                  scheduleNotifier.setColor(
                                    scheduleColorPalette[index],
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: scheduleColorPalette[index],
                                    border: schedule.color ==
                                            scheduleColorPalette[index]
                                        ? Border.all(width: 2)
                                        : null,
                                  ),
                                  child: schedule.color ==
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
                  color: schedule!.color,
                ),
              ),
              Center(
                child: SizedBox(
                  width: deviceWidth * 0.7,
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
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: deviceWidth * 0.1),
                      child: Column(
                        children: [
                          // Select group
                          groupsProfile.when(
                            data: (data) {
                              return GroupPickerButton(groupIdList: data);
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => Text('$error'),
                          ),
                          // Activity time
                          const ScheduleActivityTime(),
                          // Place
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  width: deviceWidth * 0.6,
                                  child: CupertinoTextField(
                                    controller: schedule.placeController,
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
                          // Detail
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.edit_square,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 8),
                                      width: deviceWidth * 0.6,
                                      child: CupertinoTextField(
                                        controller: schedule.detailController,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error message.
                    if (scheduleErrorMessage != null)
                      Center(
                        child: Text(
                          scheduleErrorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Button of creation
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: deviceWidth * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFF7B61FF),
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      if (schedule.groupId == null) {
                        ref.watch(scheduleErrorMessageProvider.notifier).state =
                            'No selected group.';

                        debugPrint('No selected group.');
                        return;
                      }
                      if (schedule.titleController.text.isEmpty) {
                        ref.watch(scheduleErrorMessageProvider.notifier).state =
                            'No entered title.';

                        debugPrint('No entered title.');
                        return;
                      }

                      final success = await CreateGroupSchedule.createSchedule(
                        schedule.groupId!,
                        schedule.titleController.text,
                        schedule.color,
                        schedule.placeController.text,
                        schedule.detailController.text,
                        schedule.startAt,
                        schedule.endAt,
                      );
                      if (!success) {
                        debugPrint('Failed to create schedule.');
                        return;
                      }

                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '保存',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
