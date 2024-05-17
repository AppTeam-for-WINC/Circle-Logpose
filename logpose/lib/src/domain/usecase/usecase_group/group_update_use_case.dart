import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/domain/usecase/usecase_group_schedule/group_schedule_id_use_case.dart';

import '../../../../exceptions/custom_exception.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/models/member_schedule.dart';
import '../../../data/models/user.dart';

import '../../../models/custom/group_setting_params_model.dart';

import '../../interface/i_group_repository.dart';

import '../../providers/repository/group_repository_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

import '../usecase_group_membership/group_member_creation_use_case.dart';
import '../usecase_member_schedule/group_member_schedule_creation_use_case.dart';
import '../usecase_member_schedule/group_member_schedule_use_case.dart';
import '../usecase_user/user_id_use_case.dart';

final groupUpdateUseCaseProvider = Provider<GroupUpdateUseCase>(
  (ref) {
    final userIdUseCase = ref.read(userIdUseCaseProvider);
    final memberCreationUseCase = ref.read(groupMemberCreationUseCaseProvider);
    final memberScheduleCreationUseCase =
        ref.read(groupMemberScheduleCreationUseCaseProvider);
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);
    final groupScheduleIdUseCase = ref.read(groupScheduleIdUseCaseProvider);
    final groupRepository = ref.read(groupRepositoryProvider);
    final validator = ref.read(validatorControllerProvider);

    return GroupUpdateUseCase(
      userIdUseCase: userIdUseCase,
      memberCreationUseCase: memberCreationUseCase,
      memberScheduleCreationUseCase: memberScheduleCreationUseCase,
      memberScheduleUseCase: memberScheduleUseCase,
      groupScheduleIdUseCase: groupScheduleIdUseCase,
      groupRepository: groupRepository,
      validator: validator,
    );
  },
);

class GroupUpdateUseCase {
  const GroupUpdateUseCase({
    required this.userIdUseCase,
    required this.memberCreationUseCase,
    required this.memberScheduleCreationUseCase,
    required this.memberScheduleUseCase,
    required this.groupScheduleIdUseCase,
    required this.groupRepository,
    required this.validator,
  });

  final UserIdUseCase userIdUseCase;
  final GroupMemberCreationUseCase memberCreationUseCase;
  final GroupMemberScheduleCreationUseCase memberScheduleCreationUseCase;
  final GroupMemberScheduleUseCase memberScheduleUseCase;
  final GroupScheduleIdUseCase groupScheduleIdUseCase;

  final IGroupRepository groupRepository;
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
    try {
      await groupRepository.update(
        docId: groupId,
        name: name,
        description: description,
        image: imagePath,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update group. ${e.message}');
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
    return userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<void> _createMembership(String memberDocId, String groupId) async {
    await memberCreationUseCase.createMembershipRole(memberDocId, groupId);
  }

  Future<void> _assignNewMemberSchedule(
    String memberDocId,
    String groupId,
  ) async {
    final scheduleIdList = await _fetchAllGroupScheduleId(groupId);
    await _assignMemberSchedule(memberDocId, scheduleIdList);
  }

  Future<List<String?>> _fetchAllGroupScheduleId(String groupId) async {
    return groupScheduleIdUseCase.fetchAllGroupScheduleId(groupId);
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
    return memberScheduleUseCase.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      scheduleId,
    );
  }

  Future<void> _createMemberSchedule(String scheduleId, String userId) async {
    await memberScheduleCreationUseCase.createMemberSchedule(
      scheduleId,
      userId,
    );
  }
}
