import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to create new group.
final groupAdminMemberProfileProvider =
    FutureProvider<UserProfile>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final user = await UserController.read(userDocId);

  return user;
});

/// Group adin users controller.
final groupAdminProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) async* {
  final memebershipProfilesStream =
      GroupMembershipController.readAllRoleByProfileWithGroupId(
    groupId,
    'admin',
  );

  await for (final membershipProfileList in memebershipProfilesStream) {
    final membershipProfileStream =
        membershipProfileList.map((membershipProfile) {
      if (membershipProfile == null) {
        return null;
      }
      return membershipProfile;
    }).toList();
    yield membershipProfileStream;
  }
});

/// Group membership users controller.
final groupMembershipProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) async* {
  final memebershipProfilesStream =
      GroupMembershipController.readAllRoleByProfileWithGroupId(
    groupId,
    'membership',
  );

  await for (final membershipProfileList in memebershipProfilesStream) {
    final membershipProfileStream =
        membershipProfileList.map((membershipProfile) {
      if (membershipProfile == null) {
        return null;
      }
      return membershipProfile;
    }).toList();
    yield membershipProfileStream;
  }
});

/// Used to set group membership.
final setGroupMemberListProvider = StateNotifierProvider.autoDispose<
    GroupMemberListNotifier, List<UserProfile>>(
  (ref) => GroupMemberListNotifier(),
);

///メンバーリストを追加するためのStateNotifier
class GroupMemberListNotifier extends StateNotifier<List<UserProfile>> {
  GroupMemberListNotifier() : super([]);

  void addMember(UserProfile newMember) {
    state = [...state, newMember];
  }

  void resetMemberList() {
    state = [];
  }
}
