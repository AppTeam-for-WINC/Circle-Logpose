import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../validation/max_length_validation.dart';
import '../../../../../validation/required_validation.dart';

import '../../../../models/custom/group_name_and_image_and_description_model.dart';
import '../../../../models/database/user/user.dart';

import '../../../../server/auth/auth_controller.dart';
import '../../../../server/database/group_controller.dart';
import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/user_controller.dart';

/// Used with group_creator_provider.
class GroupCreator {
  const GroupCreator();

  Future<String?> create(
    GroupNameAndImageAndDescriptionAndMemberList groupData,
  ) async {
    try {
      return await _attemptToCreateGroup(groupData);
    } on FirebaseException catch (e) {
      return 'Error: failed to create group. $e';
    }
  }

  Future<String?> _attemptToCreateGroup(
    GroupNameAndImageAndDescriptionAndMemberList groupData,
  ) async {
    final validationError = _validateGroup(groupData.groupName);
    if (validationError != null) {
      return validationError;
    }

    final userDocId = await _fetchUserDocId();
    if (userDocId == null) {
      return 'Error: No found admin user.';
    }

    final groupId = await _createGroup(groupData);
    await _createAdminRole(userDocId, groupId);
    await _createAllMembershipRole(groupId, groupData.memberList);

    return null;
  }

  String? _validateGroup(String groupName) {
    final groupNameRequiredError = const RequiredValidation().validate(
      groupName,
      'groupName',
    );
    final groupNameMaxLength32Error = const MaxLength32Validation().validate(
      groupName,
      'groupName',
    );
    if (!groupNameRequiredError) {
      return const RequiredValidation().getStringInvalidRequiredMessage();
    }
    if (!groupNameMaxLength32Error) {
      return const MaxLength32Validation().getMaxLengthInvalidMessage();
    }

    return null;
  }

  Future<String?> _fetchUserDocId() async {
    try {
      return AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
  }

  Future<String> _createGroup(
    GroupNameAndImageAndDescriptionAndMemberList groupData,
  ) async {
    try {
      return await GroupController.create(
        groupData.groupName,
        groupData.image?.path,
        groupData.description,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group. ${e.message}');
    }
  }

  Future<void> _createAdminRole(String userDocId, String groupId) async {
    try {
      await GroupMembershipController.create(userDocId, 'admin', groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create admin role. ${e.message}');
    }
  }

  Future<void> _createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    try {
      await _attemptToCreateAllMembershipsRole(groupId, memberList);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create membership roles. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: failed to get group member list. $e');
    }
  }

  Future<void> _attemptToCreateAllMembershipsRole(
    String groupId,
    List<UserProfile> memberList,
  ) async {
    await Future.wait(
      memberList.map((member) async {
        await _createMembership(member.accountId, groupId);
      }),
    );
  }

  Future<void> _createMembership(String accountId, String groupId) async {
    final memberDocId = await _fetchMemberDocId(accountId);
    await _createMembershipMember(memberDocId, groupId);
  }

  Future<String> _fetchMemberDocId(String accountId) async {
    try {
      return await UserController.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> _createMembershipMember(
    String memberDocId,
    String groupId,
  ) async {
    try {
      await GroupMembershipController.create(
        memberDocId,
        'membership',
        groupId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create membership role. ${e.message}');
    }
  }
}
