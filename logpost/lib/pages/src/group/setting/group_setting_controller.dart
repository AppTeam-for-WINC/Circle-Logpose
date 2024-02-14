import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpost/database/group/schedule/member_schedule/member_schedule_controller.dart';

import '../../../../database/group/group/group.dart';
import '../../../../database/group/group/group_controller.dart';
import '../../../../database/group/membership/group_membership_controller.dart';
import '../../../../database/group/schedule/schedule/schedule.dart';
import '../../../../database/group/schedule/schedule/schedule_controller.dart';
import '../../../../database/user/user.dart';
import '../../../../database/user/user_controller.dart';
import '../../../../validation/validation.dart';
import '../create/parts/components/group_contents_controller.dart';

/// Group setting provider.
final groupSettingProvider =
    StateNotifierProvider.family<GroupSettingNotifier, GroupProfile?, String>(
  (ref, groupId) => GroupSettingNotifier(groupId),
);

/// Switch mode of delete schedule.
final scheduleDeleteModeProvider = StateProvider<bool>((ref) => false);

/// Group of notifier.
class GroupSettingNotifier extends StateNotifier<GroupProfile?> {
  GroupSettingNotifier(this.groupId) : super(null) {
    initProfile();
  }
  TextEditingController groupNameController = TextEditingController();
  String groupId;
  GroupProfile? group;

  Future<void> initProfile() async {
    if (groupId.isEmpty) {
      state = null;
      return;
    }
    try {
      final groupStream = GroupController.read(groupId);
      await for (final groupData in groupStream) {
        if (groupData == null) {
          continue;
        }
        group = groupData;
        if (group != null) {
          state = group;
          groupNameController.text = group!.name;
        } else {
          state = null;
        }
        return;
      }
    } on Exception catch (e) {
      throw Exception('Error: No found group $e');
    }
  }

  Future<void> changeProfile(File newImage) async {
    if (state != null) {
      state = GroupProfile(
        name: state!.name,
        image: newImage.path,
        createdAt: state!.createdAt,
      );
    }
  }
}

/// Update group settings.
class UpdateGroupSettings {
  UpdateGroupSettings._internal();
  static final UpdateGroupSettings _instance = UpdateGroupSettings._internal();
  static UpdateGroupSettings get instance => _instance;

  static Future<bool> update(
    String groupId,
    String name,
    String? description,
    File? image,
    WidgetRef ref,
  ) async {
    String? imagePath;
    final nameValidation = GroupValidation.nameValidation(name);
    if (!nameValidation) {
      debugPrint('Failed to updated profile');
      return false;
    }
    if (image == null) {
      imagePath = null;
    } else {
      imagePath = image.path;
    }

    await GroupController.update(
      docId: groupId,
      name: name,
      description: description,
      image: imagePath,
    );

    final groupMembersList = ref.watch(setGroupMemberListProvider);
    await _addMeberships(groupMembersList, groupId);

    debugPrint('Success: Changed profile.');
    return true;
  }

  static Future<void> _addMeberships(
    List<UserProfile> groupMemberList,
    String groupId,
  ) async {
    try {
      await Future.forEach<UserProfile>(groupMemberList, (member) async {
        final memberDocId = await UserController.readUserDocIdWithAccountId(
          member.accountId,
        );
        await GroupMembershipController.create(
          memberDocId,
          'membership',
          groupId,
        );

        final groupScheduleIdsStream =
            GroupScheduleController.watchAllScheduleId(groupId);
        await for (final scheduleIdList in groupScheduleIdsStream) {
          for (final scheduleId in scheduleIdList) {
            if (scheduleId == null) {
              continue;
            }

            final memberScheduleList =
                await GroupMemberScheduleController.readAllGroupMemberSchedule(
              memberDocId,
              scheduleId,
            );

            if (memberScheduleList.isEmpty) {
              return GroupMemberScheduleController.create(
                scheduleId: scheduleId,
                userId: memberDocId,
              );
            }
          }
        }
      });
    } on FirebaseException catch (e) {
      throw Exception('Failed to add member. $e');
    }
  }
}

/// Validation of group
class GroupValidation {
  GroupValidation._internal();
  static final GroupValidation _instance = GroupValidation._internal();
  static GroupValidation get instance => _instance;

  static bool nameValidation(String name) {
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();

    final nameRequiredValidation = requiredValidation.validate(
      name,
      'name',
    );
    final nameMaxLength32Validation = maxLength32Validation.validate(
      name,
      'name',
    );
    if (!nameRequiredValidation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }
    if (!nameMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('nameError: $errorMessage');
      return false;
    }

    return true;
  }
}

class GroupScheduleAndId {
  GroupScheduleAndId({
    required this.groupSchedule,
    required this.groupScheduleId,
  });

  final GroupSchedule groupSchedule;
  final String groupScheduleId;
}

/// Watch group schedule and schedule ID.
final watchGroupScheduleAndIdProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    final scheduleIdStream =
        GroupScheduleController.watchAllScheduleId(groupId);

    await for (final scheduleIdList in scheduleIdStream) {
      final groupScheduleAndIdList = <GroupScheduleAndId?>[];
      for (final scheduleId in scheduleIdList) {
        if (scheduleId == null) {
          continue;
        }

        final groupSchedule = await GroupScheduleController.read(scheduleId);
        if (groupSchedule == null) {
          continue;
        }
        final groupScheduleAndId = GroupScheduleAndId(
          groupSchedule: groupSchedule,
          groupScheduleId: scheduleId,
        );
        groupScheduleAndIdList.add(groupScheduleAndId);
      }

      yield groupScheduleAndIdList;
    }
  },
);
