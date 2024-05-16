import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/group_creator_params_model.dart';
import '../../../models/database/user/user.dart';

import '../../providers/group/group/group_controller_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

import '../auth_use_case.dart';
import '../group_membership_use_case.dart';

class GroupCreationHelper {
  const GroupCreationHelper({required this.ref});
  final Ref ref;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    try {
      return await _attemptToCreateGroup(groupData);
    } on FirebaseException catch (e) {
      return 'Error: failed to create group. ${e.message}';
    }
  }

  Future<String?> _attemptToCreateGroup(GroupCreatorParams groupData) async {
    final validationError = _validateGroup(groupData.groupName);
    if (validationError != null) {
      return validationError;
    }

    final userDocId = await _fetchUserDocId();
    final groupId = await _createGroup(groupData);

    final memberUseCase = ref.read(groupMembershipUseCaseProvider);
    await _createAdminRole(memberUseCase, userDocId, groupId);
    await _createAllMembershipRole(
      memberUseCase,
      groupId,
      groupData.memberList,
    );

    return null;
  }

  String? _validateGroup(String groupName) {
    final validator = ref.read(validatorControllerProvider);
    return validator.validateGroup(groupName);
  }

  Future<String> _fetchUserDocId() async {
    final authRepository = ref.read(authUseCaseProvider);
    return authRepository.fetchCurrentUserId();
  }

  Future<String> _createGroup(GroupCreatorParams groupData) async {
    try {
      final groupRepository = ref.read(groupRepositoryProvider);
      return await groupRepository.create(
        groupData.groupName,
        groupData.image?.path,
        groupData.description,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group. ${e.message}');
    }
  }

  Future<void> _createAdminRole(
    GroupMembershipUseCase memberUseCase,
    String userDocId,
    String groupId,
  ) async {
    await memberUseCase.createAdminRole(userDocId, groupId);
  }

  Future<void> _createAllMembershipRole(
    GroupMembershipUseCase memberUseCase,
    String groupId,
    List<UserProfile> memberList,
  ) async {
    await memberUseCase.createAllMembershipRole(groupId, memberList);
  }
}
