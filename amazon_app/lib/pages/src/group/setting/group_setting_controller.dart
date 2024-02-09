import 'dart:io';

import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/pages/src/group/create/parts/components/group_contents_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Controller of group setting.
final groupSettingProvider =
    StateNotifierProvider.family<GroupSettingNotifier, GroupProfile?, String>(
  (ref, groupId) => GroupSettingNotifier(groupId),
);

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

/// Read group schedule and schedule ID.
final readGroupScheduleAndIdProvider =
    StreamProvider.family.autoDispose<List<GroupScheduleAndId>, String>(
  (ref, groupId) async* {
    final scheduleIds =
        await GroupScheduleController.readAllScheduleId(groupId).first;

    List<GroupScheduleAndId> schedulesAndIds = [];
    for (final scheduleId in scheduleIds) {
      if (scheduleId == null) {
        continue;
      }
      final schedule = await GroupScheduleController.read(scheduleId);
      if (schedule != null) {
        schedulesAndIds.add(
          GroupScheduleAndId(
            groupSchedule: schedule,
            groupScheduleId: scheduleId,
          ),
        );
      }
    }

    yield schedulesAndIds;
  },
);

// /// Read group schedule and schedule ID.
// final readGroupScheduleProvider =
//     StreamProvider.family.autoDispose<List<GroupSchedule>, String>(
//   (ref, groupId) async* {
//     final schedulesStream = GroupScheduleController.readAll(groupId);

//     await for (final schedules in schedulesStream) {
//       final scheduleList = await Future.wait(
//         schedules.map((schedule) async {
//           if (schedule == null) {
//             return null;
//           }
//           return schedule;
//         }),
//       );
//       yield scheduleList.whereType<GroupSchedule>().toList();
//     }
//   },
// );
