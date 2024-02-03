import 'dart:io';
import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/pages/src/group/create/parts/contents/group_contents_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingJudgeProvider = StateProvider<bool>((ref) => false);

///Create group.
Future<bool> createGroup(
  String groupName,
  File? image,
  String? groupDescription,
  WidgetRef ref,
) async {
  final validation = groupValidation(groupName);
  if (!validation) {
    debugPrint('Failed to create group.');
    return false;
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

  ref.watch(groupMemberListProvider).map((member) async {
    final memberDocId =
        await UserController.readUserDocIdWithAccountId(member.accountId);
    await GroupMembershipController.create(memberDocId, 'member', groupId,);
  });

  debugPrint('Success: Created group');
  return true;
}


///Group Validation
bool groupValidation(String groupName) {
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
    return false;
  }
  if (!groupNameMaxLength32Validation) {
    final errorMessage =
        const MaxLength32Validation().getMaxLengthInvalidMessage();

    debugPrint('groupNameError: $errorMessage');
    return false;
  }

  return true;
}
