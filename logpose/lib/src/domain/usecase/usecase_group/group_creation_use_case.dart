import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/models/user.dart';

import '../../../models/custom/group_creator_params_model.dart';

import '../../interface/i_group_repository.dart';

import '../../providers/repository/group_repository_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

import '../usecase_group_membership/group_member_creation_use_case.dart';
import '../usecase_user/user_id_use_case.dart';

final groupCreationUseCaseProvider = Provider<GroupCreationUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final groupMemberCreationUseCase =
      ref.read(groupMemberCreationUseCaseProvider);
  final groupRepository = ref.read(groupRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);

  return GroupCreationUseCase(
    userIdUseCase: userIdUseCase,
    groupMemberCreationUseCase: groupMemberCreationUseCase,
    groupRepository: groupRepository,
    validator: validator,
  );
});

class GroupCreationUseCase {
  const GroupCreationUseCase({
    required this.userIdUseCase,
    required this.groupMemberCreationUseCase,
    required this.groupRepository,
    required this.validator,
  });

  final UserIdUseCase userIdUseCase;
  final GroupMemberCreationUseCase groupMemberCreationUseCase;
  final IGroupRepository groupRepository;
  final ValidatorController validator;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    try {
      return await _attemptToCreateGroup(groupData);
    } on Exception catch (e) {
      return 'Error: failed to create group. $e';
    }
  }

  Future<String?> _attemptToCreateGroup(GroupCreatorParams groupData) async {
    final validationError = _validateGroup(groupData.groupName);
    if (validationError != null) {
      return validationError;
    }

    final userDocId = await _fetchUserDocId();
    final groupId = await _createGroup(groupData);

    await _createAdminRole(userDocId, groupId);
    await _createAllMembershipRole(groupId, groupData.memberList);

    return null;
  }

  String? _validateGroup(String groupName) {
    return validator.validateGroup(groupName);
  }

  Future<String> _fetchUserDocId() async {
    return userIdUseCase.fetchCurrentUserId();
  }

  Future<String> _createGroup(GroupCreatorParams groupData) async {
    try {
      return await groupRepository.create(
        groupData.groupName,
        groupData.image?.path,
        groupData.description,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group. ${e.message}');
    }
  }

  Future<void> _createAdminRole(String userDocId, String groupId) async {
    return groupMemberCreationUseCase.createAdminRole(userDocId, groupId);
  }

  Future<void> _createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    return groupMemberCreationUseCase.createAllMembershipRole(
      groupId,
      memberList,
    );
  }
}
