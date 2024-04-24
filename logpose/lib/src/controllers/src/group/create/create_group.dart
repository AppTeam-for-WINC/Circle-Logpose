import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../validation/max_length_validation.dart';
import '../../../../../validation/required_validation.dart';

import '../../../../models/user/user.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_controller.dart';
import '../../../../services/database/group_membership_controller.dart';
import '../../../../services/database/user_controller.dart';
import '../../../providers/group/member/set_group_member_list_provider.dart';

/// Create group.
class CreateGroup {
  CreateGroup._internal();
  static final CreateGroup _instance = CreateGroup._internal();
  static CreateGroup get instance => _instance;

  /// Create group.
  static Future<String?> create(
    String groupName,
    File? image,
    String? groupDescription,
    WidgetRef ref,
  ) async {
    try {
      final validationError = _groupValidation(groupName);
      if (validationError != null) {
        return validationError;
      }

      final userDocId = await _fetchUserDocId();
      if (userDocId == null) {
        return 'Error: No found admin user.';
      }

      final groupId = await _createGroup(
        groupName,
        image?.path,
        groupDescription,
      );
      await _createAdminMember(groupName, groupId);
      await _addMemberships(ref, groupId);

      return null;
    } on Exception catch (e) {
      return 'Error: $e';
    }
  }

  static String? _groupValidation(String groupName) {
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

  static Future<String?> _fetchUserDocId() async {
    return AuthController.getCurrentUserId();
  }

  static Future<String> _createGroup(
    String groupName,
    String? imagePath,
    String? description,
  ) async {
    return GroupController.create(
      groupName,
      imagePath,
      description,
    );
  }

  static Future<void> _createAdminMember(
    String userDocId,
    String groupId,
  ) async {
    await GroupMembershipController.create(userDocId, 'admin', groupId);
  }

  /// Add memberships to group.
  static Future<void> _addMemberships(
    WidgetRef ref,
    String groupId,
  ) async {
    final groupMemberList = ref.watch(setGroupMemberListProvider);
    await Future.forEach<UserProfile>(groupMemberList, (member) async {
      final memberDocId = await _fetchMemberDocId(member.accountId);
      await _createMembershipMember(memberDocId, groupId);
    });
  }

  static Future<String> _fetchMemberDocId(String accountId) async {
    return UserController.readUserDocIdWithAccountId(
      accountId,
    );
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
}
