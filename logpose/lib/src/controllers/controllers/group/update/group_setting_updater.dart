import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../exceptions/custom_exception.dart';
import '../../../../../exceptions/group/group_schedule_exception.dart';
import '../../../../../exceptions/group/group_setting_exception.dart';
import '../../../../../exceptions/group/member_schedule_exception.dart';
import '../../../../../exceptions/group/membership_exception.dart';
import '../../../../../exceptions/user/user_exception.dart';

import '../../../../models/custom/group_setting_params_model.dart';
import '../../../../models/database/group/member_schedule.dart';
import '../../../../models/database/user/user.dart';

import '../../../../server/database/group_controller.dart';
import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/group_schedule_controller.dart';
import '../../../../server/database/member_schedule_controller.dart';
import '../../../../server/database/user_controller.dart';

import '../../../validation/group/group_validation.dart';

/// Used with group_setting_updater_provider.
class GroupSettingUpdater {
  const GroupSettingUpdater();

  Future<String?> update(GroupSettingParams groupData) async {
    try {
      return await _attemptToUpdate(groupData);
    } on Exception catch (e) {
      return 'Error: Failed to update group. $e';
    }
  }

  Future<String?> _attemptToUpdate(GroupSettingParams groupData) async {
    final nameValidation = GroupValidation.nameValidation(groupData.groupName);
    if (nameValidation != null) {
      return nameValidation;
    }

    await _updateGroup(
      groupId: groupData.groupId,
      name: groupData.groupName,
      description: groupData.description,
      imagePath: groupData.image?.path,
    );

    await _addMemberships(groupData.memberList, groupData.groupId);

    return null;
  }

  Future<void> _updateGroup({
    required String groupId,
    required String name,
    required String? description,
    required String? imagePath,
  }) async {
    try {
      await GroupController.update(
        docId: groupId,
        name: name,
        description: description,
        image: imagePath,
      );
    } on FirebaseException catch (e) {
      throw GroupUpdateException(
        'Error: failed to update group. ${e.message}',
      );
    }
  }

  Future<void> _addMemberships(
    List<UserProfile> groupMemberList,
    String groupId,
  ) async {
    try {
      await Future.wait(
        groupMemberList.map((member) async {
          await _executeToAddMember(member, groupId);
        }),
      );
    } on Exception catch (e) {
      throw MembershipException('Error: failed to add members. $e');
    }
  }

  Future<void> _executeToAddMember(UserProfile member, String groupId) async {
    try {
      final memberDocId = await _fetchUserDocId(member.accountId);
      await _createMembership(memberDocId, groupId);
      await _watchAllScheduleId(memberDocId, groupId);
    } on Exception catch (e) {
      throw CustomException('Error: unexpected error occured. $e');
    }
  }

  Future<String> _fetchUserDocId(String accountId) async {
    try {
      return await UserController.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw UserException('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> _createMembership(String memberDocId, String groupId) async {
    try {
      await GroupMembershipController.create(
        memberDocId,
        'membership',
        groupId,
      );
    } on FirebaseException catch (e) {
      throw MembershipException(
        'Error: failed to create group membership. ${e.message}',
      );
    }
  }

  Future<void> _watchAllScheduleId(String memberDocId, String groupId) async {
    final scheduleIdList = await _fetchAllGroupScheduleId(groupId);
    await _assignMemberSchedule(memberDocId, scheduleIdList);
  }

  Future<List<String?>> _fetchAllGroupScheduleId(String groupId) async {
    try {
      return await GroupScheduleController.fetchAllScheduleIdFuture(groupId);
    } on FirebaseException catch (e) {
      throw GroupScheduleException(
        'Error: failed to fetch group schedule. ${e.message}',
      );
    }
  }

  Future<void> _assignMemberSchedule(
    String memberDocId,
    List<String?> scheduleIdList,
  ) async {
    for (final scheduleId in scheduleIdList) {
      if (scheduleId == null) {
        continue;
      }

      final memberSchedule =
          await _fetchGroupMemberSchedule(memberDocId, scheduleId);
      if (memberSchedule == null) {
        await _createMemberSchedule(scheduleId, memberDocId);
      }
    }
  }

  Future<GroupMemberSchedule?> _fetchGroupMemberSchedule(
    String userDocId,
    String scheduleId,
  ) async {
    try {
      return await GroupMemberScheduleController.fetchGroupMemberSchedule(
        userDocId: userDocId,
        scheduleId: scheduleId,
      );
    } on FirebaseException catch (e) {
      throw MemberScheduleException(
        'Error: failed to fetch member schedule. ${e.message}',
      );
    }
  }

  Future<void> _createMemberSchedule(String scheduleId, String userId) async {
    try {
      await GroupMemberScheduleController.create(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      throw MemberScheduleException(
        'Error: failed to create member schedule. ${e.message}',
      );
    }
  }
}
