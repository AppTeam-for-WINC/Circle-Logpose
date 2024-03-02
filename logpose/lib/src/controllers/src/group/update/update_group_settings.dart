import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';

import '../../../../services/database/group_controller.dart';
import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

import '../../../providers/group/member/set_group_member_list_provider.dart';
import '../../../validation/group/group_validation.dart';

/// Update group settings.
class UpdateGroupSettings {
  UpdateGroupSettings._internal();
  static final UpdateGroupSettings _instance = UpdateGroupSettings._internal();
  static UpdateGroupSettings get instance => _instance;

  static Future<String?> update(
    String groupId,
    String name,
    String? description,
    File? image,
    WidgetRef ref,
  ) async {
    String? imagePath;
    final nameValidationErrorMessage = GroupValidation.nameValidation(name);
    if (nameValidationErrorMessage != null) {
      return nameValidationErrorMessage;
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

    return null;
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
              await GroupMemberScheduleController.create(
                scheduleId: scheduleId,
                userId: memberDocId,
              );
            }
          }
          return;
        }
      });
    } on FirebaseException catch (e) {
      throw Exception('Failed to add member. $e');
    }
  }
}
