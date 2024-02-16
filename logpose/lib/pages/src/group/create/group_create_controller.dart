import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/auth/auth_controller.dart';
import '../../../../database/group/group/group_controller.dart';
import '../../../../database/group/membership/group_membership_controller.dart';
import '../../../../database/user/user.dart';
import '../../../../database/user/user_controller.dart';
import '../../../../validation/validation.dart';
import 'parts/components/set_member_controller.dart';

class CreateGroup {
  CreateGroup._internal();
  static final CreateGroup _instance =
      CreateGroup._internal();
  static CreateGroup get instance => _instance;

  ///Create group.
  static Future<String?> createGroup(
    String groupName,
    File? image,
    String? groupDescription,
    WidgetRef ref,
  ) async {
    final validation = _groupValidation(groupName);
    if (validation != null) {
      debugPrint('Failed to create group.');
      return validation;
    }

    final groupId = await GroupController.create(
      groupName,
      image?.path,
      groupDescription,
    );

    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      throw Exception('Error: No found admin user.');
    } else {
      await GroupMembershipController.create(userDocId, 'admin', groupId);
    }

    final groupMembersList = ref.watch(setGroupMemberListProvider);
    await _addMeberships(groupMembersList, groupId);

    debugPrint('Success: Created group');
    return null;
  }

  /// Add memberships to group.
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

  /// Group Validation
  static String? _groupValidation(String groupName) {
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();
    final groupNameRequiredValidation = requiredValidation.validate(
      groupName,
      'groupName',
    );
    final groupNameMaxLength32Validation = maxLength32Validation.validate(
      groupName,
      'groupName',
    );
    if (!groupNameRequiredValidation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('groupNameError: $errorMessage');
      return errorMessage;
    }
    if (!groupNameMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('groupNameError: $errorMessage');
      return errorMessage;
    }

    return null;
  }
}
