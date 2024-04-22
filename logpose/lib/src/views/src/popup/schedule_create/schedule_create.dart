import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/color_palette.dart';

import '../../../../controllers/providers/group/error/schedule_error_msg_provider.dart';
import '../../../../controllers/providers/group/group/watch_joined_group_profile_provider.dart';
import '../../../../controllers/providers/group/schedule/group_schedule_provider.dart';
import '../../../../controllers/providers/group/schedule/text/schedule_detail_controller_provider.dart';
import '../../../../controllers/providers/group/schedule/text/schedule_place_controller_provider.dart';
import '../../../../controllers/providers/group/schedule/text/schedule_title_controller_provider.dart';
import '../../../../controllers/src/group/create/create_group_schedule.dart';

import 'components/group_picker/group_picker_button.dart';
import 'components/schedule_activity_time.dart';

class ScheduleCreate extends ConsumerStatefulWidget {
  const ScheduleCreate({super.key, this.groupId});

  final String? groupId;
  @override
  ConsumerState createState() => _ScheduleCreateState();
}

class _ScheduleCreateState extends ConsumerState<ScheduleCreate> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupId = widget.groupId;
    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);
    final schedule = ref.watch(setGroupScheduleProvider(null));
    final scheduleNotifier = ref.watch(setGroupScheduleProvider(null).notifier);
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
                    controller: ref
                        .watch(scheduleTitleControllerProvider.notifier)
                        .state,
                    placeholder: 'タイトルを追加',
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
                    onChanged: (String text) {
                      ref
                          .read(scheduleTitleControllerProvider.notifier)
                          .state
                          .text = text;
                    },
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
                                    controller: ref
                                        .watch(
                                          schedulePlaceControllerProvider
                                              .notifier,
                                        )
                                        .state,
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
                                    onChanged: (String text) {
                                      ref
                                          .read(
                                            schedulePlaceControllerProvider
                                                .notifier,
                                          )
                                          .state
                                          .text = text;
                                    },
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
                                        controller: ref
                                            .watch(
                                              scheduleDetailControllerProvider
                                                  .notifier,
                                            )
                                            .state,
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
                                        onChanged: (String text) {
                                          ref
                                              .watch(
                                                scheduleDetailControllerProvider
                                                    .notifier,
                                              )
                                              .state
                                              .text = text;
                                        },
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
                      if (schedule.groupId == null && groupId == null) {
                        ref.watch(scheduleErrorMessageProvider.notifier).state =
                            'No selected group.';

                        return;
                      } else if (schedule.groupId == null && groupId != null){
                        scheduleNotifier.setGroupId(groupId);
                      }

                      final errorMessage = await CreateGroupSchedule.create(
                        schedule.groupId!,
                        ref.read(scheduleTitleControllerProvider).text,
                        schedule.color!,
                        ref.read(schedulePlaceControllerProvider).text,
                        ref.read(scheduleDetailControllerProvider).text,
                        schedule.startAt,
                        schedule.endAt,
                      );
                      if (errorMessage != null) {
                        ref.watch(scheduleErrorMessageProvider.notifier).state =
                            errorMessage;
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
