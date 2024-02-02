import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupWithId {
  GroupWithId({required this.group, required this.groupId});
  final GroupProfile group;
  final String groupId;
}

final readJoinedGroupsProfileProvider =
    StreamProvider<List<GroupWithId>>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not login.');
  }
  final membershipsStream =
      GroupMembershipController.readAllWithUserId(userDocId);

  await for (final memberships in membershipsStream) {
    final groupsWithId = await Future.wait(
      memberships.map((membership) async {
        if (membership == null) {
          return null;
        }
        final group = await GroupController.read(membership.groupId);
        return GroupWithId(group: group, groupId: membership.groupId);
      }),
    );
    yield groupsWithId.whereType<GroupWithId>().toList();
  }
});
