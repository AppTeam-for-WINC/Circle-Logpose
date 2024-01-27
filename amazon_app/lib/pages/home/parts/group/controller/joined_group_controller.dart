import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final readJoinedGroupsProfileProvider =
    FutureProvider<List<Future<Group>>>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final memberships =
      await GroupMembershipController.readAllWithUserId(userDocId);
  final groups = memberships.map((membership) async {
    final group = await GroupController.read(membership.groupId);
    print('result: ${group.image}');
    return group;
  }).toList();

  return groups;
});



// 画像の追加の際にデフォルト画像しかアップロードできない状態になってしまっている。