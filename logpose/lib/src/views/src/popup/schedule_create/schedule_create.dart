import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/color_palette.dart';

import '../../../../controllers/providers/group/group/joined_group_profile_provider.dart';
import '../../../../controllers/providers/group/error/schedule_error_msg_provider.dart';
import '../../../../controllers/providers/group/schedule/group_schedule_provider.dart';
import '../../../../controllers/src/group/create/create_group_schedule.dart';

import 'components/group_picker/group_picker_button.dart';
import 'components/schedule_activity_time.dart';

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
    final schedule = ref.watch(groupScheduleProvider);
    final scheduleNotifier = ref.watch(groupScheduleProvider.notifier);
    final groupsProfile = ref.watch(watchJoinedGroupsProfileProvider);

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
                onPressed: () {
                  // Init
                  scheduleNotifier.initSchedule();

                  Navigator.of(context).pop();
                },
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

                        return;
                      }

                      final errorMessage =
                          await CreateGroupSchedule.create(
                        schedule.groupId!,
                        schedule.titleController.text,
                        schedule.color,
                        schedule.placeController.text,
                        schedule.detailController.text,
                        schedule.startAt,
                        schedule.endAt,
                      );
                      if (errorMessage != null) {
                        ref
                            .watch(scheduleErrorMessageProvider.notifier)
                            .state = errorMessage;
                        return;
                      }

                      // Init
                      scheduleNotifier.initSchedule();

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
