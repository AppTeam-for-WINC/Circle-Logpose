import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/loading_progress.dart';

import '../../../../components/group/group_schedule_tile/group_schedule_tile.dart';
import '../../../../components/image/custom_image.dart';
import '../../../../components/popup/add_member/add_member.dart';
import '../../../../components/popup/create_schedule/create_schedule.dart';
import '../../../../components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../../../../controllers/controllers/group/update/update_group_settings.dart';
import '../../../../controllers/providers/error/group_name_error_msg_provider.dart';
import '../../../../controllers/providers/group/admin/watch_group_admin_profile_list_provider.dart';
import '../../../../controllers/providers/group/group/group_setting_provider.dart';
import '../../../../controllers/providers/group/member/group_member_profile_list_provider.dart';
import '../../../../controllers/providers/group/member/set_group_member_list_provider.dart';
import '../../../../controllers/providers/group/mode/schedule_delete_mode_provider.dart';
import '../../../../controllers/providers/group/schedule/watch_group_schedule_and_id_provider.dart';
import '../../../../controllers/providers/group/text/selected_group_name_provider.dart';

import '../../../../entities/device/image_controller.dart';
// import '../../../common/progress/progress_indicator.dart';

class GroupSettingPage extends ConsumerStatefulWidget {
  const GroupSettingPage({super.key, required this.groupId});
  final String groupId;

  @override
  ConsumerState<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends ConsumerState<GroupSettingPage> {
  File? image;

  /// Select image.
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return 'no image';
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      return 'Success: selected image.';
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
      return 'Failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupId = widget.groupId;

    final isLoading = ref.watch(loadingProgressProvider);
    // final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);
    final groupNameErrorMessage = ref.watch(groupNameErrorMessageProvider);
    final groupAdminProfileList =
        ref.watch(watchGroupAdminProfileListProvider(groupId));
    final groupMembershipProfileList =
        ref.watch(watchGroupMembershipProfileListProvider(groupId));
    final groupProfile = ref.watch(groupSettingProvider(groupId));
    final groupProfileNotifier =
        ref.watch(groupSettingProvider(groupId).notifier);
    final asyncGroupScheduleList =
        ref.watch(watchGroupScheduleAndIdProvider(groupId));

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 246),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
            Navigator.pop(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) =>
                    const ScheduleListAndJoinedGroupTabSlider(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 233, 233, 246),
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Container(
          width: deviceWidth * 0.4,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFD9D9D9),
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
            color: const Color(0xFF7B61FF),
            borderRadius: BorderRadius.circular(80),
          ),
          child: const Center(
            child: Text(
              '団体編集',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        trailing: CupertinoButton(
          onPressed: () async {
            await showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('団体を削除しますか?'),
                  content: const Text('削除後、元に戻すことはできません。'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.delete_forever,
            color: Color(0xFF7B61FF),
            size: 30,
          ),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth * 0.85,
                height: deviceHeight * 0.215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (groupProfile != null)
                            CustomImage(
                              imagePath: groupProfile.image,
                              width: deviceWidth * 0.17,
                              height: deviceHeight * 0.0765,
                            )
                          else
                            Icon(
                              Icons.group,
                              size: deviceWidth * 0.17,
                              color: Colors.grey,
                            ),
                          const Icon(
                            Icons.cached_sharp,
                            size: 30,
                            color: Colors.grey,
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              final imageGetResult = await pickImage();
                              if (imageGetResult == 'Failed') {
                                if (!mounted) {
                                  return;
                                }
                                await showPhotoAccessDeniedDialog(context);
                              }
                              if (image != null) {
                                await groupProfileNotifier.changeImage(image!);
                              }
                            },
                            child: const SizedBox(
                              child: Icon(
                                Icons.image,
                                size: 70,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error message.
                    if (groupNameErrorMessage != null)
                      Text(
                        groupNameErrorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),

                    Container(
                      width: deviceWidth * 0.65,
                      height: deviceHeight * 0.05,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 219, 251),
                        borderRadius: BorderRadius.circular(80),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10,
                        ),
                        child: CupertinoTextField(
                          controller: groupProfileNotifier.groupNameController,
                          prefix: const Icon(
                            Icons.create_sharp,
                            color: Color(0xFF6D6D6D),
                          ),
                          style: const TextStyle(fontSize: 16),
                          placeholder: '団体名',
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 244, 219, 251),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: deviceWidth * 0.88,
                height: deviceHeight * 0.1,
                child: Stack(
                  children: [
                    Container(
                      width: deviceWidth * 0.85,
                      height: deviceHeight * 0.08,
                      margin: const EdgeInsets.only(top: 10, left: 6),
                      padding: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 3),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'メンバー',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                            ClipRect(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.8,
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      groupAdminProfileList.when(
                                        data: (membershipProfiles) {
                                          return Column(
                                            children: membershipProfiles
                                                .map((membershipProfile) {
                                              return membershipProfile != null
                                                  ? CustomImage(
                                                      imagePath:
                                                          membershipProfile
                                                              .image,
                                                      width: 30,
                                                      height: 30,
                                                    )
                                                  : const SizedBox.shrink();
                                            }).toList(),
                                          );
                                        },
                                        loading: () => const SizedBox.shrink(),
                                        error: (error, stack) => Text('$error'),
                                      ),
                                      groupMembershipProfileList.when(
                                        data: (membershipProfiles) {
                                          return Row(
                                            children: membershipProfiles
                                                .map((membershipProfile) {
                                              return membershipProfile != null
                                                  ? CustomImage(
                                                      imagePath:
                                                          membershipProfile
                                                              .image,
                                                      width: 30,
                                                      height: 30,
                                                    )
                                                  : const SizedBox.shrink();
                                            }).toList(),
                                          );
                                        },
                                        loading: () => const SizedBox.shrink(),
                                        error: (error, stack) => Text('$error'),
                                      ),

                                      // Set user's image list.
                                      ...ref
                                          .watch(setGroupMemberListProvider)
                                          .map(
                                            (member) => groupProfile != null
                                                ? CustomImage(
                                                    imagePath: member.image,
                                                    width: 30,
                                                    height: 30,
                                                  )
                                                : const Text('No member'),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -15,
                      right: -15,
                      child: CupertinoButton(
                        onPressed: () async {
                          await showCupertinoModalPopup<AddMember>(
                            context: context,
                            builder: (BuildContext context) {
                              return AddMember(
                                groupId: groupId,
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8EB61),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_add,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: deviceWidth * 0.89,
                height: deviceHeight * 0.36,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: deviceWidth * 0.85,
                        height: deviceHeight * 0.36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 3),
                              blurRadius: 3,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    '予定一覧',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                width: deviceWidth * 0.7,
                                height: deviceHeight * 0.3,
                                padding: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                  bottom: 5,
                                ),
                                child: GridView.count(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  crossAxisCount: 1,
                                  childAspectRatio: 6,
                                  mainAxisSpacing: 12,
                                  children: asyncGroupScheduleList.when(
                                    data: (groupScheduleList) {
                                      if (groupScheduleList.isEmpty) {
                                        return const [SizedBox.shrink()];
                                      }
                                      return groupScheduleList
                                          .map((groupScheduleData) {
                                        if (groupScheduleData == null) {
                                          return const SizedBox.shrink();
                                        }
                                        return groupAdminProfileList.when(
                                          data: (membershipProfiles) {
                                            return GroupScheduleTile(
                                              groupId: groupId,
                                              schedule: groupScheduleData,
                                              groupName: groupProfileNotifier
                                                  .groupNameController.text,
                                              groupMemberList:
                                                  membershipProfiles,
                                            );
                                          },
                                          loading: () =>
                                              const SizedBox.shrink(),
                                          error: (error, stack) =>
                                              Text('$error'),
                                        );
                                      }).toList();
                                    },
                                    loading: () => const [SizedBox.shrink()],
                                    error: (error, stack) => [Text('$error')],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          ref.watch(selectedGroupNameProvider.notifier).state =
                              groupProfileNotifier.groupNameController.text;
                          await showCupertinoModalPopup<CreateSchedule>(
                            context: context,
                            builder: (BuildContext context) {
                              return CreateSchedule(groupId: groupId);
                            },
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8EB61),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.calendar_badge_plus,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          ref.watch(scheduleDeleteModeProvider.notifier).state =
                              !ref.watch(scheduleDeleteModeProvider);
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEB6161),
                            borderRadius: BorderRadius.circular(44),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.calendar_badge_minus,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final errorMessage = await UpdateGroupSettings.update(
                          groupId,
                          groupProfileNotifier.groupNameController.text,
                          null,
                          image,
                          ref,
                        );
                        if (errorMessage != null) {
                          ref
                              .watch(groupNameErrorMessageProvider.notifier)
                              .state = errorMessage;
                          return;
                        }

                        if (!mounted) {
                          return;
                        }
                        await Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                            builder: (context) =>
                                const ScheduleListAndJoinedGroupTabSlider(),
                          ),
                          (_) => false,
                        );
                      },
                color: const Color(0xFF7B61FF),
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 117,
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('変更を保存'),
                    ],
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
