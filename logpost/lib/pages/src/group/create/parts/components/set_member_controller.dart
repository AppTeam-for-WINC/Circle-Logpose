import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../database/user/user.dart';

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
