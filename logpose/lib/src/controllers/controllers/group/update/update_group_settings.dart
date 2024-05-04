import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/models/database/group/member_schedule.dart';

import '../../../../services/database/group_controller.dart';
import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/group_schedule_controller.dart';
import '../../../../services/database/member_schedule_controller.dart';
import '../../../../services/database/user_controller.dart';

import '../../../providers/group/members/membership/set_group_member_list_provider.dart';
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
    try {
      final nameValidation = GroupValidation.nameValidation(name);
      if (nameValidation != null) {
        return nameValidation;
      }

      await _updateGroup(
        groupId,
        name,
        description,
        image?.path,
      );
      await _addMemberships(ref, groupId);
    } on FirebaseException catch (e) {
      return 'Error: Failed to update group data. $e';
    }

    return null;
  }

  static Future<void> _updateGroup(
    String docId,
    String name,
    String? description,
    String? imagePath,
  ) async {
    await GroupController.update(
      docId: docId,
      name: name,
      description: description,
      image: imagePath,
    );
  }

  static Future<void> _addMemberships(WidgetRef ref, String groupId) async {
    final groupMemberList = ref.watch(setGroupMemberListProvider);
    await Future.wait(
      groupMemberList.map((member) async {
        final memberDocId = await _fetchUserDocId(member.accountId);
        await _createMembershipMember(memberDocId, groupId);
        await _watchAllScheduleId(memberDocId, groupId);
      }),
    );
  }

  static Future<void> _watchAllScheduleId(
    String memberDocId,
    String groupId,
  ) async {
    final scheduleIdList =
        await GroupScheduleController.readAllScheduleIdFuture(groupId);
    await _assignMemberSchedule(memberDocId, scheduleIdList);
  }

  static Future<void> _assignMemberSchedule(
    String memberDocId,
    List<String?> scheduleIdList,
  ) async {
    for (final scheduleId in scheduleIdList) {
      if (scheduleId == null) {
        continue;
      }

      final memberSchedule = await _fetchGroupMemberSchedule(
        memberDocId,
        scheduleId,
      );
      if (memberSchedule == null) {
        await _createMemberSchedule(scheduleId, memberDocId);
      }
    }
  }

  static Future<String> _fetchUserDocId(String accountId) async {
    return UserController.readUserDocIdWithAccountId(accountId);
  }

  static Future<void> _createMembershipMember(
    String memberDocId,
    String groupId,
  ) async {
    await GroupMembershipController.create(
      memberDocId,
      'membership',
      groupId,
    );
  }

  static Future<GroupMemberSchedule?> _fetchGroupMemberSchedule(
    String userDocId,
    String scheduleId,
  ) async {
    return GroupMemberScheduleController.readGroupMemberSchedule(
      userDocId: userDocId,
      scheduleId: scheduleId,
    );
  }

  static Future<void> _createMemberSchedule(
    String scheduleId,
    String userId,
  ) async {
    await GroupMemberScheduleController.create(
      scheduleId: scheduleId,
      userId: userId,
    );
  }
}
