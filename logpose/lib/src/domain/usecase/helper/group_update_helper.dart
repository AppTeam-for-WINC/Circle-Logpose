import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../exceptions/custom_exception.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../../data/repository/database/group_repository.dart';
import '../../../data/repository/database/group_schedule_repository.dart';
import '../../../data/repository/database/member_schedule_repository.dart';
import '../../../data/repository/database/user_repository.dart';

import '../../../models/custom/group_setting_params_model.dart';
import '../../../models/database/group/member_schedule.dart';
import '../../../models/database/user/user.dart';

import '../../validator/validator_controller.dart';

import '../group_member_schedule_use_case.dart';
import '../group_membership_use_case.dart';
import '../group_schedule_use_case.dart';
import '../user_use_case.dart';

/// Used with group_setting_updater_provider.
class GroupUpdateHelper {
  const GroupUpdateHelper({
    required this.ref,
    required this.groupRepository,
    required this.memberRepository,
    required this.groupScheduleRepository,
    required this.groupMemberScheduleRepository,
    required this.userRepository,
    required this.validator,
  });

  final Ref ref;
  final GroupRepository groupRepository;
  final GroupMembershipRepository memberRepository;
  final GroupScheduleRepository groupScheduleRepository;
  final GroupMemberScheduleRepository groupMemberScheduleRepository;
  final UserRepository userRepository;
  final ValidatorController validator;

  Future<String?> updateGroup(GroupSettingParams groupData) async {
    try {
      return await _attemptToUpdate(groupData);
    } on Exception catch (e) {
      return 'Error: Failed to update group. $e';
    }
  }

  Future<String?> _attemptToUpdate(GroupSettingParams groupData) async {
    final validationError = _validateGroup(groupData.groupName);
    if (validationError != null) {
      return validationError;
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

  String? _validateGroup(String name) {
    return validator.validateGroup(name);
  }

  Future<void> _updateGroup({
    required String groupId,
    required String name,
    required String? description,
    required String? imagePath,
  }) async {
    await groupRepository.update(
      docId: groupId,
      name: name,
      description: description,
      image: imagePath,
    );
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
      throw CustomException('Error: failed to add members. $e');
    }
  }

  Future<void> _executeToAddMember(UserProfile member, String groupId) async {
    try {
      final memberDocId = await _fetchUserDocId(member.accountId);
      await _createMembership(memberDocId, groupId);
      await _assignNewMemberSchedule(memberDocId, groupId);
    } on Exception catch (e) {
      throw CustomException('Error: unexpected error occured. $e');
    }
  }

  Future<String> _fetchUserDocId(String accountId) async {
    final userUseCase = ref.read(userUseCaseProvider);
    return userUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<void> _createMembership(String memberDocId, String groupId) async {
    final memberUseCase = ref.read(groupMembershipUseCaseProvider);
    await memberUseCase.createMembershipRole(memberDocId, groupId);
  }

  Future<void> _assignNewMemberSchedule(String memberDocId, String groupId) async {
    final scheduleIdList = await _fetchAllGroupScheduleId(groupId);
    await _assignMemberSchedule(memberDocId, scheduleIdList);
  }

  Future<List<String?>> _fetchAllGroupScheduleId(String groupId) async {
    final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);
    return groupScheduleUseCase.fetchAllGroupScheduleId(groupId);
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
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);
    return memberScheduleUseCase.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      scheduleId,
    );
  }

  Future<void> _createMemberSchedule(String scheduleId, String userId) async {
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);
    await memberScheduleUseCase.createMemberSchedule(scheduleId, userId);
  }
}
